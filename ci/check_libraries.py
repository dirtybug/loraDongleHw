import csv
from pathlib import Path
import re
import sys

base = Path("/usr/share/kicad")
local = Path("KiCad/Libraries")
missing = []


def find_symbol(lib: str, name: str) -> bool:
    for path in (local / f"{lib}.kicad_sym", base / "symbols" / f"{lib}.kicad_sym"):
        if path.exists() and re.search(r'\(symbol\s+"' + re.escape(name) + r'"', path.read_text(encoding="utf-8", errors="ignore")):
            return True
    symdir = base / "symbols" / f"{lib}.kicad_symdir" / f"{name}.kicad_sym"
    return symdir.exists()


def find_footprint(lib: str, name: str) -> bool:
    for path in (
        local / f"{lib}.pretty" / f"{name}.kicad_mod",
        base / "footprints" / f"{lib}.pretty" / f"{name}.kicad_mod",
    ):
        if path.exists():
            return True
    return False


with open("KiCad/Libraries/components.csv", newline="", encoding="utf-8") as f:
    for row in csv.DictReader(f):
        ref = row["Reference"]
        for field in ("Symbol", "Footprint"):
            value = row[field].strip()
            if not value:
                print(f"{ref}: {field} UNRESOLVED")
                missing.append(f"{ref}:{field}")
                continue
            lib, name = value.split(":", 1)
            ok = find_symbol(lib, name) if field == "Symbol" else find_footprint(lib, name)
            print(f"{ref}: {value}: {'OK' if ok else 'MISSING'}")
            if not ok:
                missing.append(value)

print(f"Unresolved or missing entries: {len(missing)}")
sys.exit(bool(missing))
