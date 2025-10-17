# 🎨 XFCE Theme Switcher Ultimate

**XFCE Theme Switcher Ultimate** is an interactive Bash script that makes it easy for you to replace XFCE themes with various cool styles such as *Arch Linux look*, *Ultra Lite*, and restore them to their default appearance.  
Equipped with an automatic **log** system, you can see theme change history easily.

---

## 🧠 Main Features

✅ Change XFCE theme to various modes:
- **Arch-Look Lite** → Looks similar to Arch Linux with low RAM consumption  
- **Arch-Look Full** → Dock above, modern look like Arch Linux  
- **Ultra Lite Mode** → Performance focus, super saving RAM ⚡  
- **Restore to Default** → Restore XFCE display to normal  
- **Reset XFCE Config** → Removes the XFCE configuration to return it to its initial state

🪵 **Auto Log Feature**
- Record all theme changes complete with date and time  
- Can be viewed or deleted directly from the menu

💡 **Interface**
- Interactive menu display with ASCII art logo  
- Loading bar animation when settings are applied  

---

## ⚙️ How to Install

1. Make sure you have installed `git`:
   ```bash
   sudo apt install git -y
   ```

2. This clone repository:
   ```bash
   git clone https://github.com/LawGZ/xfce-theme-switcher.git
   cd xfce-theme-switcher
   ```

3. Make the script executable:
   ```bash
   chmod +x xfce-theme-switcher.sh
   ```

4. Run:
   ```bash
   ./xfce-theme-switcher.sh
   ```

---

## ṣ️ Log File Location

All theme change history is saved in:
```
~/.local/share/xfce-theme-switcher/log.txt
```

Example of log content:
```
[Fri-17-Oct-2025 21:59] switch from: Default → Arch-Look Lite
[Fri-17-Oct-2025 22:07] switch from: Arch-Look Lite → Arch-Look Full (Upper Dock)
```

---

## 🔧 Dependencies (Dependencies)

This script will automatically install the following packages if they don't already exist:
- `arc-theme`
- `papyrus-icon-theme`
- `plank`
- `fonts-jetbrains-mono`
- `fonts-noto`
- `gtk2-engines-murrine`
- `gtk2-engines-pixbuf`
- `neofetch`

---

## 📦 Uninstall (Optional)

If you want to delete logs and configurations:
```bash
rm -rf ~/.local/share/xfce-theme-switcher ~/.config/xfce4 ~/.cache/sessions/xfce4*
```

---

## 👨 ⁇ 💻 Maker

**Author:** [lawiis](https://github.com/<username>)  
🧩 Script created with ❤️ for XFCE users who like a clean & light display.

---

## 📜 License

This project is licensed under the **MIT License** – is free to use and modify, as long as it still includes the creator's credit.
