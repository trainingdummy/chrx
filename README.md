# chrx Generic - Universal Chromebook Linux Installer

A fork of the original [chrx](https://chrx.org) installer, redesigned to work with **any** Linux distribution that provides a rootfs tarball. Install your favorite distro on your Chromebook with a single command!

## 🚀 Quick Start

Install chrx and set up Linux on your Chromebook with one command, run twice:

```bash
curl -L https://tinyurl.com/td-chrx | sudo tar xzfC - /usr/local && chrx
```

### First Run (Partition Mode)
- Creates a partition for Linux
- Asks for desired partition size (default: 16 GB)
- Formats the partition
- Prompts you to run the command again

### Second Run (Install Mode)
- Downloads and installs Linux
- Default: Zorin OS 17 Core
- Configures system settings
- Installs GRUB bootloader
- Sets up dual-boot with ChromeOS

## ✨ Features

- **Universal**: Works with any Linux distro that provides a tar.gz rootfs
- **Two-step process**: Partition once, install once
- **Smart detection**: Automatically determines which mode to run
- **URL support**: Handles direct downloads and shortlinks (TinyURL, bit.ly, etc.)
- **Interactive TUI**: Beautiful text-based menus for easy configuration
- **Non-interactive mode**: Full automation with command-line options
- **GRUB automation**: Automatically installs and configures GRUB
- **Dual-boot**: Seamlessly coexists with ChromeOS

## 📋 Requirements

- Chromebook in Developer Mode
- 8+ GB free disk space (16+ GB recommended)
- Internet connection

## 🎯 Usage

### Interactive Mode (Recommended for first-time users)

Simply run the command and follow the prompts:

```bash
curl -L https://tinyurl.com/td-chrx | sudo tar xzfC - /usr/local && chrx
```

The installer will guide you through:
1. Setting partition size
2. Choosing your distro (via URL)
3. Configuring hostname, username, timezone
4. Setting passwords

### Non-Interactive Mode

Fully automated installation with command-line options:

```bash
# First run - create 32GB partition
chrx -s 32 -y

# Second run - install custom distro
chrx -u https://example.com/my-distro.tar.gz -H mycomputer -U myuser -P mypassword -y
```

### Command-Line Options

| Option | Description | Example |
|--------|-------------|---------|
| `-u URL` | Rootfs tar.gz download URL | `-u https://example.com/distro.tar.gz` |
| `-s SIZE` | Partition size in GB | `-s 32` |
| `-t DISK` | Target disk device | `-t /dev/mmcblk0` |
| `-H HOSTNAME` | System hostname | `-H mycomputer` |
| `-U USERNAME` | User account name | `-U myuser` |
| `-P PASSWORD` | Root password | `-P mypassword` |
| `-L LOCALE` | System locale | `-L en_US.UTF-8` |
| `-Z TIMEZONE` | System timezone | `-Z America/New_York` |
| `-y` | Non-interactive mode | `-y` |
| `-v` | Verbose output | `-v` |
| `-h` | Show help | `-h` |

## 🎨 Supported Distributions

chrx-generic works with **any** Linux distribution that provides a rootfs tarball. Popular options include:

- **Arch Linux**: https://mirrors.kernel.org/archlinux/iso/latest/
- **Ubuntu**: https://cdimage.ubuntu.com/ubuntu-base/
- **Debian**: https://www.debian.org/distrib/
- **Fedora**: https://alt.fedoraproject.org/
- **Gentoo**: https://www.gentoo.org/downloads/
- **Alpine**: https://alpinelinux.org/downloads/
- **Void Linux**: https://voidlinux.org/download/

### Default Distribution

By default, chrx-generic installs **Zorin OS 17 Core**:
- URL: https://tinyurl.com/chrx-zorin-17
- Size: ~2.5 GB download
- Features: Ubuntu-based, Windows-like interface, beginner-friendly

## 🔧 Advanced Usage

### Custom Distributions

To install a custom distribution:

1. Find a rootfs tar.gz file for your chosen distro
2. Use the `-u` option with the direct download URL:

```bash
chrx -u https://example.com/path/to/rootfs.tar.gz
```

### Creating Rootfs Archives

If your favorite distro doesn't provide a rootfs tarball, you can create one:

1. Install the distro in a VM or container
2. Create a tarball of the root filesystem:

```bash
sudo tar czf my-distro-rootfs.tar.gz -C /path/to/root .
```

3. Upload to a web server and use with chrx

### Partition Sizes

Recommended partition sizes by use case:

- **Minimal**: 8-16 GB (CLI-only, basic tools)
- **Standard**: 16-32 GB (Desktop environment, common apps)
- **Developer**: 32-64 GB (IDEs, build tools, containers)
- **Workstation**: 64+ GB (Heavy workloads, multimedia)

## 🖥️ After Installation

### Booting

After rebooting, at the "OS verification is OFF" screen:

- Press **CTRL+D** to boot ChromeOS
- Press **CTRL+L** to boot Linux

### Default Credentials

- Username: `chrx` (or your specified username)
- Password: `chrx` (or your specified password)

**⚠️ IMPORTANT**: Change your password immediately after first login!

```bash
passwd
```

### Post-Installation Steps

Depending on your distribution, you may need to:

1. **Configure networking**:
   ```bash
   # For systemd-based distros
   sudo systemctl enable NetworkManager
   sudo systemctl start NetworkManager
   ```

2. **Update the system**:
   ```bash
   # Ubuntu/Debian
   sudo apt update && sudo apt upgrade
   
   # Arch
   sudo pacman -Syu
   
   # Fedora
   sudo dnf upgrade
   ```

3. **Install additional packages**:
   - Graphics drivers
   - Firmware packages
   - Desktop environment (if not included)

## 🛠️ Troubleshooting

### "Partition 7 not found"

Run chrx in partition mode first:
```bash
chrx -s 16 -y
```

### "Unable to access URL"

- Check your internet connection
- Verify the URL is correct and accessible
- Try with `-v` for verbose output

### GRUB doesn't install

Some minimal rootfs archives don't include GRUB. Install it manually after setup:

```bash
sudo apt install grub-pc  # Ubuntu/Debian
sudo pacman -S grub       # Arch
```

Then run:
```bash
sudo grub-install /dev/sdX
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

### Boot hangs or fails

Try updating the bootloader:
```bash
sudo update-grub  # Ubuntu/Debian
sudo grub-mkconfig -o /boot/grub/grub.cfg  # Others
```

## 🏗️ Development

### Building from Source

1. Clone the repository:
   ```bash
   git clone https://github.com/YOUR-USERNAME/chrx-generic.git
   cd chrx-generic
   ```

2. Make your changes to the `chrx` script

3. Build the distribution package:
   ```bash
   chmod +x build.sh
   ./build.sh
   ```

4. Test locally:
   ```bash
   sudo tar xzfC dist.tar.gz /usr/local
   sudo chrx
   ```

### Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly on a Chromebook
5. Submit a pull request

## 📝 Differences from Original chrx

This fork differs from the original chrx in several ways:

| Feature | Original chrx | chrx-generic |
|---------|---------------|--------------|
| Supported distros | Pre-configured list | Any distro with tar.gz |
| Configuration | Distro-specific tweaks | Generic, minimal |
| Customization files | Extensive per-distro files | User provides rootfs |
| Bootloader | Conditional GRUB install | Always attempts GRUB |
| URL support | Internal mirrors | Any public URL |
| Interface | CLI-focused | Modern TUI menus |

## 📜 License

This project is a fork of the original chrx, which is licensed under the GPL. This fork maintains the same license.

## 🙏 Credits

- Original chrx by reynhout and contributors
- GalliumOS team for Chromebook Linux pioneering
- The ChromeOS and Linux communities

## 💬 Support

- Open an issue on GitHub
- Check the [Troubleshooting](#-troubleshooting) section
- Visit the [chrx.org](https://chrx.org) documentation

## ⚠️ Disclaimer

This software modifies your Chromebook's disk partitions. While designed to be safe:

- **Backup your data** before proceeding
- Use at your own risk
- Not responsible for data loss or hardware damage
- Test in a non-critical environment first

---

**Made with ❤️ by the Chromebook Linux community**
