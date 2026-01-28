# Squoosh_Batch_CLI
Squoosh_Batch_CLI is a terminal tool that uses ChromeLabs' Squoosh tool for bulk image process &amp; compression as the website doesn't allow us to do so.

---

## Squoosh CLI Setup and Bulk Image Compression Documentation

This documentation provides step-by-step instructions for installing and running Squoosh CLI on Windows using WSL and Ubuntu.

---

## Prerequisites

- Windows 10/11 with WSL support
- Internet connection
- Administrative access to install software

---

## Step 1: Install WSL

1. Open Command Prompt or PowerShell.
2. Run:
```bash
wsl.exe --list --online
```
3. Choose a Linux distribution (Ubuntu is recommended) and install:
```bash
wsl --install -d Ubuntu
```
4. Launch Ubuntu and create a user account:
```bash
# Follow prompts to create username and password
```

---

## Step 2: Update Ubuntu and Install Prerequisites

Update Ubuntu packages:
```bash
sudo apt update
```

Install required packages:
```bash
sudo apt install -y curl gnupg ca-certificates apt-transport-https
```

---

## Step 3: Install Node.js

### Option 1: Node.js 20 (may cause WebAssembly errors)
```bash
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs
```
Check version:
```bash
node -v
```

### Option 2: Node.js 18 (Recommended if Node 20 fails)
```bash
sudo apt remove -y nodejs
sudo apt autoremove -y
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs
```
Check version:
```bash
node -v
```

---

## Step 4: Install Squoosh CLI

Install globally using `npm`:
```bash
sudo npm install -g @squoosh/cli
```

> **Note:** Use `sudo` if you encounter permission errors.

---

## Step 5: Fix WebAssembly URL Issue (if applicable)

If you encounter the `ERR_INVALID_URL` error when running Squoosh CLI:
```bash
export NODE_OPTIONS="--no-experimental-fetch"
```

---

## Step 6: Prepare Input and Output Folders

Inside your project directory:
```bash
mkdir input output
```
Place all images you want to compress inside the `input` folder.

---

## Step 7: Run Squoosh CLI for Bulk Compression

Compress all PNG, JPG, and JPEG files to WebP format with quality 75:
```bash
squoosh-cli \
  --webp '{"quality":75}' \
  input/*.png input/*.jpg input/*.jpeg \
  -d output
```

Optional: Adjust compression effort:
```bash
squoosh-cli \
  --webp '{"quality":75, "effort":6}' \
  input/*.png input/*.jpg input/*.jpeg \
  -d output
```

---

## Step 8: Verify Output

List files in the output folder:
```bash
ls output
```
Check sizes and compression results.

---

## Notes

- Node.js 18 is recommended for Squoosh CLI to avoid WebAssembly fetch issues.
- Always use `sudo` when installing global npm packages to prevent permissions errors.
- The `input` folder should contain only the images you want to compress.
- The `output` folder will store all converted WebP files.

---

## References

- [Squoosh CLI GitHub](https://github.com/GoogleChromeLabs/squoosh)
- [NodeSource Node.js Setup](https://github.com/nodesource/distributions)
- [WSL Installation Guide](https://learn.microsoft.com/en-us/windows/wsl/install)

---

_End of Documentation_


