import csv
from pathlib import Path
import re
import sys
base=Path("/usr/share/kicad")
missing=[]
with open("KiCad/Libraries/components.csv", newline="") as f:
    for row in csv.DictReader(f):
        ref=row["Reference"]
        for field in ("Symbol","Footprint"):
            value=row[field]
            if not value:
                print(f"{ref}: {field} UNRESOLVED")
                missing.append(f"{ref}:{field}")
                continue
            lib,name=value.split(":",1)
            if field=="Symbol":
                path=base/"symbols"/(lib+".kicad_sym")
                ok=path.exists() and re.search(r'\(symbol\s+"'+re.escape(name)+r'"',path.read_text()) is not None
            else:
                path=base/"footprints"/(lib+".pretty")/(name+".kicad_mod")
                ok=path.exists()
            print(f"{ref}: {value}: {'OK' if ok else 'MISSING'}")
            if not ok: missing.append(value)
print(f"Unresolved or missing entries: {len(missing)}")
sys.exit(bool(missing))
