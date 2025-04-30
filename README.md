# hyprmonitor

<!-- [![License](https://img.shields.io/github/license/binoymanoj/hyprmonitor)](./LICENSE) -->
[![Hyprland](https://img.shields.io/badge/Compatible%20with-Hyprland-44cc11?logo=linux)](https://github.com/hyprwm/Hyprland)
[![Status](https://img.shields.io/badge/status-active-brightgreen)]()

A simple command line utility to turn **on/off monitors** in **Hyprland** window manager.

---

## 🧰 Features

- Supports multiple monitors
- Interactive selection of monitors
- Clean CLI usage with help menu
- Depends only on `hyprctl` 
- Lightweight and minimal

---

## 🚀 Usage

### ✅ Turn off a monitor:
```bash
hyprmonitor off
```

### ✅ Turn on a monitor:
```bash
hyprmonitor on
```

### 📖 Help:
```bash
hyprmonitor -h
```

---

## 💡 Installation

### 1. Clone the repo:
```bash
git clone git@github.com:binoymanoj/hyprmonitors.git
```

### 2. Make scripts executable:
```bash
chmod +x install.sh
chmod +x hyprmonitors.sh
```

### 3. Run the install script:
```bash
./install.sh
```

---

## 🖥️ Example

```bash
$ hyprmonitor off

Available monitors:
[0] eDP-1
[1] HDMI-A-1
Enter the number of the monitor to turn off: 1
Monitor 'HDMI-A-1' turned off.
```

---

## ⚙️ Dependencies

- `hyprctl` (comes with hyprland)

---

## 🧑‍💻 Author
Binoy Manoj
🔗 https://binoymanoj.in
📸 GitHub: @binoymanoj


