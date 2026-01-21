#!/bin/bash

# Script to backup and restore code files to their original state
# Usage:
#   ./restore.sh backup  - Create a backup of current files
#   ./restore.sh restore - Restore files from backup

BACKUP_DIR=".backup_snapshot"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

backup() {
	echo "Creating backup..."

	# Create backup directory if it doesn't exist
	if [ ! -d "$BACKUP_DIR" ]; then
		mkdir -p "$BACKUP_DIR"
	fi

	# Create timestamped backup subdirectory
	BACKUP_PATH="$BACKUP_DIR/backup_$TIMESTAMP"
	mkdir -p "$BACKUP_PATH"

	# Copy all files except hidden files, backup directory, and this script
	find . -maxdepth 1 -type f ! -name ".*" ! -name "restore.sh" -exec cp {} "$BACKUP_PATH/" \;

	# Save the backup path to a "latest" file for easy restoration
	echo "$BACKUP_PATH" > "$BACKUP_DIR/latest_backup"

	echo "Backup created at: $BACKUP_PATH"
	echo "Files backed up:"
	ls -1 "$BACKUP_PATH"
}

refresh_vscode_buffers() {
	if command -v code >/dev/null 2>&1; then
		# Revert all open files to disk contents to discard unsaved edits
		code --reuse-window --command workbench.action.files.revertAll >/dev/null 2>&1
	fi
}

restore_from_snapshot() {
	# Restore all files from backup
	cp -v "$RESTORE_PATH"/* .
}

restore() {
	echo "Restoring from backup..."

	# Check if backup directory exists
	if [ ! -d "$BACKUP_DIR" ]; then
		echo "Error: No backups found. Run './restore.sh backup' first."
		exit 1
	fi

	# Get the latest backup path
	if [ -f "$BACKUP_DIR/latest_backup" ]; then
		RESTORE_PATH=$(cat "$BACKUP_DIR/latest_backup")
	else
		echo "Error: No backup record found."
		exit 1
	fi

	# Check if the backup path exists
	if [ ! -d "$RESTORE_PATH" ]; then
		echo "Error: Backup directory not found: $RESTORE_PATH"
		exit 1
	fi

	echo "Restoring from: $RESTORE_PATH"

	restore_from_snapshot

	# Refresh VS Code editor buffers so unsaved changes are discarded
	refresh_vscode_buffers

	echo "Restoration complete!"
}

# Main script logic
case "$1" in
	backup)
		backup
		;;
	restore)
		restore
		;;
	*)
		echo "Usage: $0 {backup|restore}"
		echo "  backup  - Create a backup of current files"
		echo "  restore - Restore files from the most recent backup"
		exit 1
		;;
esac
