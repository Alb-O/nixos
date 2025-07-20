# Ly Display Manager Authentication Issue After dbus-broker Change

## 1. Problem Description
After switching to `dbus-broker` as the system bus implementation in NixOS, Ly display manager was unable to authenticate any user for any session (Hyprland, shell, etc). Authentication worked fine on TTY, but not via Ly. This issue appeared immediately after a recent change to the dbus configuration.

## 2. Previous Configuration
In `modules/system.nix`:
```nix
services.displayManager.ly.enable = true;
services.dbus.implementation = "broker";
```
No explicit configuration to ensure a dbus user session was available.

## 3. Diagnosis
- Ly would open and immediately close sessions for the user, as seen in the logs.
- No authentication errors, but sessions would not persist.
- No dbus user session was being started, which is required for modern compositors and shells.

## 4. Solution (Current State)
Added the following to `modules/system.nix`:
```nix
services.dbus.packages = [ pkgs.dbus ];
```
This ensures the dbus user session is available for all users, allowing Ly to properly start sessions and authenticate users.

## 5. Expected Result
- Ly should now authenticate users and start sessions (Hyprland, shell, etc) as expected.
- The dbus user session will be available, resolving issues with session startup and authentication.
