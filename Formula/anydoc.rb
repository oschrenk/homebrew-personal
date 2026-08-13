class Anydoc < Formula
  desc "Convert Word, PowerPoint, Excel, OpenDocument, RTF, EPUB, CSV and PDF to Markdown"
  homepage "https://github.com/firecrawl/anydoc"
  url "https://registry.npmjs.org/@firecrawl/anydoc/-/anydoc-0.1.8.tgz"
  sha256 "8f92d2adb297ec8ce03e79fd74030e9b60f3e4d1d7c6e06382c021c513cf8a3d"
  license "MIT"

  livecheck do
    url "https://registry.npmjs.org/@firecrawl/anydoc/latest"
    strategy :json do |json|
      json["version"]
    end
  end

  depends_on "node"

  # anydoc's Rust core ships as prebuilt napi modules, one npm package per
  # platform, pulled in as optionalDependencies of @firecrawl/anydoc. Fetching
  # the one module for this platform keeps the install to two tarballs and no
  # dependency resolution. Bump the version in each URL alongside its sha256.
  on_macos do
    on_arm do
      resource "native" do
        url "https://registry.npmjs.org/@firecrawl/anydoc-darwin-arm64/-/anydoc-darwin-arm64-0.1.8.tgz"
        sha256 "3a3417f7021a75b90581473d8be7499427e976214fbdd6cd2eadf7044b37c513"
      end
    end
    on_intel do
      resource "native" do
        url "https://registry.npmjs.org/@firecrawl/anydoc-darwin-x64/-/anydoc-darwin-x64-0.1.8.tgz"
        sha256 "6995a4b9d06c00365c0d6b18e9149c44d017060db2da3a0c3ffafbe6163420e5"
      end
    end
  end

  on_linux do
    on_arm do
      resource "native" do
        url "https://registry.npmjs.org/@firecrawl/anydoc-linux-arm64-gnu/-/anydoc-linux-arm64-gnu-0.1.8.tgz"
        sha256 "fd938c005c4fa965ff242d4f245f9f1b0988c03a9fa3647d1f524cd472bb7fca"
      end
    end
    on_intel do
      resource "native" do
        url "https://registry.npmjs.org/@firecrawl/anydoc-linux-x64-gnu/-/anydoc-linux-x64-gnu-0.1.8.tgz"
        sha256 "8519762dc76735f2bb5471381be9bdeade0393153e6efaaa33af27be15e317f0"
      end
    end
  end

  def install
    # cli.js requires ./index.js and ./package.json (for --version) at runtime.
    libexec.install "cli.js", "index.js", "index.d.ts", "package.json"
    chmod 0755, libexec/"cli.js"

    resource("native").stage do
      libexec.install Dir["*.node"]
    end
    native_module = libexec.glob("*.node").fetch(0)

    # index.js checks NAPI_RS_NATIVE_LIBRARY_PATH before its platform-detection
    # cascade, so pointing it at the one module we ship skips that entirely.
    (bin/"anydoc").write_env_script libexec/"cli.js",
                                    NAPI_RS_NATIVE_LIBRARY_PATH: native_module,
                                    PATH:                        "#{Formula["node"].opt_bin}:$PATH"

    # Upstream ships no completions and the CLI is a hand-rolled argument
    # parser with no generator, so this is maintained here: keep it in step
    # with cli.js when its flags or formats change.
    (buildpath/"anydoc.fish").write fish_completion_script
    fish_completion.install "anydoc.fish"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/anydoc --version")
    assert_match "convert documents", shell_output("#{bin}/anydoc --help")

    # Exercises the native module, not just the argument parser.
    (testpath/"data.csv").write "name,count\nwidget,2\n"
    assert_match "widget", shell_output("#{bin}/anydoc data.csv")
    assert_match "widget", pipe_output("#{bin}/anydoc - --format csv", "name,count\nwidget,2\n")

    assert_match "unknown option", shell_output("#{bin}/anydoc --nope 2>&1", 2)
  end

  private

  # Canonical --format values. The extension aliases (xls, docm, ppsx, ...)
  # resolve to these and are accepted too, but are not offered.
  FORMATS = {
    "doc"  => "Word 97-2003",
    "docx" => "Word (OOXML)",
    "odt"  => "OpenDocument Text",
    "pdf"  => "PDF",
    "ppt"  => "PowerPoint 97-2003",
    "pptx" => "PowerPoint (OOXML)",
    "rtf"  => "Rich Text Format",
    "epub" => "EPUB",
    "xlsx" => "Excel workbook",
    "ods"  => "OpenDocument Spreadsheet",
    "odp"  => "OpenDocument Presentation",
    "csv"  => "Comma-separated values",
  }.freeze

  # Every extension the CLI resolves to a format, for completing the document
  # argument.
  EXTENSIONS = %w[
    doc docx docm odt pdf ppt pps pot pptx pptm ppsx ppsm
    rtf epub xls xlsx xlsm xlsb ods odp csv
  ].freeze

  def fish_completion_script
    # One rule for every value: a rule per format would leave --format itself
    # described as whichever format came last.
    formats = FORMATS.map { |name, description| "#{name}\\t'#{description}'" }.join(" ")
    suffixes = EXTENSIONS.map { |extension| ".#{extension}" }.join(" ")

    <<~FISH
      # anydoc converts one document per invocation; - reads it from stdin.
      complete -c anydoc -f

      complete -c anydoc -s o -l output -r -F -d 'Write the Markdown to <path> instead of stdout'
      complete -c anydoc -s f -l format -x -d 'Name the input format instead of detecting it' -a "#{formats}"
      complete -c anydoc -s h -l help -d 'Print this help and exit'
      complete -c anydoc -s V -l version -d 'Print the version and exit'

      complete -c anydoc -n __fish_is_first_arg -k -a '(__fish_complete_suffix #{suffixes})'
      complete -c anydoc -n __fish_is_first_arg -a - -d 'Read the document from stdin'
    FISH
  end
end
