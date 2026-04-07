# Development

## Testing Local Formulas

The tap is installed at `/opt/homebrew/Library/Taps/oschrenk/homebrew-personal`. To test a formula before pushing:

1. Copy the formula into the tap directory:

   ```
   cp Casks/<name>.rb /opt/homebrew/Library/Taps/oschrenk/homebrew-personal/Casks/
   ```

2. Install:

   ```
   brew install oschrenk/personal/<name>
   ```

3. Clean up the copied file after testing:

   ```
   rm /opt/homebrew/Library/Taps/oschrenk/homebrew-personal/Casks/<name>.rb
   ```

> **Note:** Copying files directly into the tap directory means `brew update` may overwrite or conflict with your local changes. Only use this for quick local testing before committing and pushing.
