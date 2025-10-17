#!/bin/bash
# ========================================
# XFCE Theme Switcher Ultimate + Log System
# by lawiis 
# ========================================

# ---------- SETUP ----------
LOG_DIR="$HOME/.local/share/xfce-theme-switcher"
LOG_FILE="$LOG_DIR/log.txt"
mkdir -p "$LOG_DIR"

# ---------- ASCII LOGO ----------
show_logo() {
clear
echo -e "\e[36m"
cat <<'EOF'
██╗  ██╗███████╗ ██████╗███████╗    ████████╗██╗  ██╗███████╗███╗   ███╗███████╗
██║  ██║██╔════╝██╔════╝██╔════╝    ╚══██╔══╝██║  ██║██╔════╝████╗ ████║██╔════╝
███████║█████╗  ██║     █████╗         ██║   ███████║█████╗  ██╔████╔██║███████╗
██╔══██║██╔══╝  ██║     ██╔══╝         ██║   ██╔══██║██╔══╝  ██║╚██╔╝██║╚════██║
██║  ██║███████╗╚██████╗███████╗       ██║   ██║  ██║███████╗██║ ╚═╝ ██║███████║
╚═╝  ╚═╝╚══════╝ ╚═════╝╚══════╝       ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝╚══════╝
                               by lawiis
EOF
echo -e "\e[0m"
}

# ---------- LOADING BAR ----------
loading_bar() {
    echo -ne "\n⚙️  Applying settings: "
    for i in {1..20}; do
        echo -ne "█"
        sleep 0.05
    done
    echo -e "  Done!\n"
}

# ---------- LOG FUNCTION ----------
log_change() {
    local from="$1"
    local to="$2"
    local tanggal=$(LC_TIME=id_ID.UTF-8 date '+%a-%d-%b-%Y %H:%M')
    echo "[$tanggal] switch from: $from → $to" >> "$LOG_FILE"
}

# ---------- LOG VIEWER ----------
show_log_menu() {
    while true; do
        clear
        echo "===== 📜 Riwayat Pergantian Tema ====="
        if [ -s "$LOG_FILE" ]; then
            cat "$LOG_FILE"
        else
            echo "(Belum ada log yang tersimpan)"
        fi
        echo "======================================"
        echo "1. Hapus Log"
        echo "2. Kembali ke Menu Utama"
        echo "======================================"
        read -p "Pilih opsi [1-2]: " log_choice

        case $log_choice in
            1)
                read -p "⚠️  Yakin ingin menghapus semua log? (y/N): " confirm
                if [[ $confirm =~ ^[Yy]$ ]]; then
                    > "$LOG_FILE"
                    echo "🧹 Log berhasil dihapus."
                else
                    echo "❌ Dibatalkan."
                fi
                sleep 1
                ;;
            2)
                return
                ;;
            *)
                echo "❌ Pilihan tidak valid."
                sleep 1
                ;;
        esac
    done
}
# ---------- MENU ----------
show_menu() {
    show_logo
    echo "=============================="
    echo " XFCE Theme Switcher Ultimate"
    echo "=============================="
    echo "1. Arch-Look Lite (Hemat RAM)"
    echo "2. Kembalikan ke Default"
    echo "3. Arch-Look Full (Dock di atas)"
    echo "4. Arch-Look Ultra Lite (Super Hemat RAM)"
    echo "5. Restore Safe (Reset XFCE)"
    echo "------------------------------"
    echo "6. 📜 Lihat Log Pergantian Tema"
    echo "7. 🧰 Keluar"
    echo "=============================="
    read -p "Pilih opsi [1-7]: " choice
    echo
}

# ---------- MAIN LOGIC ----------
CURRENT_THEME="Unknown"

# Deteksi tema XFCE saat ini
CURRENT_THEME=$(xfconf-query -c xsettings -p /Net/ThemeName 2>/dev/null)
[ -z "$CURRENT_THEME" ] && CURRENT_THEME="Unknown"

while true; do
    clear
    show_menu
    
    case $choice in
        1)
            show_logo
            echo "=== Arch-Look Lite ==="
            loading_bar
            sudo apt update && sudo apt install -y arc-theme papirus-icon-theme fonts-jetbrains-mono fonts-noto gtk2-engines-murrine gtk2-engines-pixbuf neofetch

            mkdir -p ~/.themes ~/.icons ~/Pictures
            wget -q https://raw.githubusercontent.com/archlinux/archinstall/master/assets/archlinux-wallpaper.jpg -O ~/Pictures/arch-wallpaper.jpg

            xfconf-query -c xsettings -p /Net/ThemeName -s "Arc-Dark"
            xfconf-query -c xsettings -p /Net/IconThemeName -s "Papirus-Dark"
            xfconf-query -c xsettings -p /Gtk/FontName -s "JetBrains Mono 10"
            xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/image-path -s "$HOME/Pictures/arch-wallpaper.jpg"
            xfconf-query -c xfce4-panel -p /panels/panel-1/position -s "p=2;x=0;y=0"
            xfconf-query -c xfce4-panel -p /panels/panel-1/autohide-behavior -s 2
            xfconf-query -c xfce4-panel -p /panels/panel-1/size -s 34
            xfconf-query -c xfwm4 -p /general/use_compositing -s false

            grep -q "neofetch" ~/.bashrc || echo "neofetch" >> ~/.bashrc

            log_change "$CURRENT_THEME" "Arch-Look Lite"
            CURRENT_THEME="Arch-Look Lite"
            clear
            echo "✅ XFCE sekarang tampil seperti Arch Linux (Lite)."
            sleep 1.5
            ;;
        2)
            show_logo
            echo "=== Kembalikan ke Default ==="
            loading_bar
            xfconf-query -c xsettings -p /Net/ThemeName -s "Greybird"
            xfconf-query -c xsettings -p /Net/IconThemeName -s "Adwaita"
            xfconf-query -c xsettings -p /Gtk/FontName -s "Sans 10"
            xfconf-query -c xfwm4 -p /general/use_compositing -s true
            sed -i '/neofetch/d' ~/.bashrc

            DEFAULT_WALLPAPER="/usr/share/backgrounds/xfce/xfce-blue.jpg"
            [ -f "$DEFAULT_WALLPAPER" ] && xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/image-path -s "$DEFAULT_WALLPAPER"

            log_change "$CURRENT_THEME" "Default"
            CURRENT_THEME="Default"
            clear
            echo "✅ XFCE dikembalikan ke tampilan default."
            sleep 1.5
            ;;
        3)
            show_logo
            echo "=== Arch-Look Full (Dock di atas) ==="
            loading_bar
            sudo apt update && sudo apt install -y arc-theme papirus-icon-theme plank fonts-jetbrains-mono fonts-noto gtk2-engines-murrine gtk2-engines-pixbuf neofetch

            mkdir -p ~/.config/plank/dock1 ~/.config/autostart
            wget -q https://raw.githubusercontent.com/archlinux/archinstall/master/assets/archlinux-wallpaper.jpg -O ~/Pictures/arch-wallpaper.jpg

            xfconf-query -c xsettings -p /Net/ThemeName -s "Arc-Dark"
            xfconf-query -c xsettings -p /Net/IconThemeName -s "Papirus-Dark"
            xfconf-query -c xsettings -p /Gtk/FontName -s "JetBrains Mono 10"
            xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/image-path -s "$HOME/Pictures/arch-wallpaper.jpg"
            xfconf-query -c xfce4-panel -p /panels/panel-1/position -s "p=2;x=0;y=0"
            xfconf-query -c xfce4-panel -p /panels/panel-1/autohide-behavior -s 2
            xfconf-query -c xfwm4 -p /general/use_compositing -s true

            cat > ~/.config/plank/dock1/settings <<'EOF'
[PlankDockPreferences]
Alignment=Center
AutoHide=true
Position=Top
HideMode=2
IconSize=46
ItemPadding=6
EOF

            cat > ~/.config/autostart/plank.desktop <<'EOF'
[Desktop Entry]
Type=Application
Name=Plank
Exec=plank
Comment=Autostart Plank Dock
X-GNOME-Autostart-enabled=true
EOF

            pkill plank 2>/dev/null || true
            nohup plank >/dev/null 2>&1 &

            grep -q "neofetch" ~/.bashrc || echo "neofetch" >> ~/.bashrc

            log_change "$CURRENT_THEME" "Arch-Look Full (Dock Atas)"
            CURRENT_THEME="Arch-Look Full (Dock Atas)"
            clear
            echo "✅ XFCE sekarang tampil seperti Arch Linux (Full Dock)."
            sleep 1.5
            ;;
        4)
            show_logo
            echo "=== Mode Ultra Lite (Super Hemat RAM) ==="
            loading_bar
            xfconf-query -c xsettings -p /Net/ThemeName -s "Raleigh" 2>/dev/null || xfconf-query -c xsettings -p /Net/ThemeName -s "Adwaita"
            xfconf-query -c xsettings -p /Net/IconThemeName -s "Adwaita"
            xfconf-query -c xfce4-panel -p /panels/panel-1/size -s 24
            xfconf-query -c xfce4-panel -p /panels/panel-1/autohide-behavior -s 0
            xfconf-query -c xfwm4 -p /general/use_compositing -s false
            xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/color-style -s 1
            xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/color1 -s "#000000"
            sed -i '/neofetch/d' ~/.bashrc

            log_change "$CURRENT_THEME" "Ultra Lite"
            CURRENT_THEME="Ultra Lite"
            clear
            echo "✅ XFCE diatur ke mode Ultra Lite ⚡"
            sleep 1.5
            ;;
        5)
            show_logo
            echo "⚠️ Restore konfigurasi XFCE ke default."
            read -p "Yakin lanjut? (y/N): " confirm
            [[ ! $confirm =~ ^[Yy]$ ]] && echo "❌ Dibatalkan." && sleep 1 && continue

            loading_bar
            rm -rf ~/.config/xfce4 ~/.cache/sessions/xfce4* 2>/dev/null
            log_change "$CURRENT_THEME" "Reset XFCE"
            echo "✅ XFCE dikembalikan ke kondisi awal."
            sleep 1.5
            ;;
        6)
            show_logo
            show_log_menu
            ;;
        7)
            echo "👋 Anda Keluar dari Theme Switcher."
            exit 0
            ;;
        *)
            echo "❌ Pilihan tidak valid."
            sleep 1
            ;;
    esac
done
