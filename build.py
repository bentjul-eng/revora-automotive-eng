#!/usr/bin/env python3
"""Builds pecas_ie.db (schema.sql + seed.sql) and generates index.html (template.html + data from the database).

Usage:  python3 build.py
Uses only the Python standard library.
"""
import json
import sqlite3
from pathlib import Path

ROOT = Path(__file__).parent
DB_PATH = ROOT / "pecas_ie.db"
HTML_PATH = ROOT / "index.html"


def build_db() -> sqlite3.Connection:
    if DB_PATH.exists():
        DB_PATH.unlink()
    con = sqlite3.connect(DB_PATH)
    con.row_factory = sqlite3.Row
    con.executescript((ROOT / "schema.sql").read_text(encoding="utf-8"))
    con.executescript((ROOT / "seed.sql").read_text(encoding="utf-8"))
    con.execute("PRAGMA foreign_keys = ON")
    problems = con.execute("PRAGMA foreign_key_check").fetchall()
    if problems:
        raise SystemExit(f"foreign_key_check failed: {[tuple(p) for p in problems]}")
    con.commit()
    return con


def export_data(con: sqlite3.Connection) -> dict:
    vehicles = [
        dict(r)
        for r in con.execute(
            """SELECT v.vehicle_id, m.name AS make, v.model, v.generation,
                      v.year_start, v.year_end, v.drive_side, v.market_region
               FROM vehicles v JOIN manufacturers m USING (manufacturer_id)
               ORDER BY m.name, v.model"""
        )
    ]

    parts = []
    for p in con.execute("SELECT * FROM parts ORDER BY part_id"):
        fits = [
            dict(r)
            for r in con.execute(
                """SELECT c.vehicle_id, c.fitment_position, c.confidence,
                          s.name AS source_name, s.url AS source_url, s.reliability_score
                   FROM part_vehicle_compatibility c
                   LEFT JOIN sources s USING (source_id)
                   WHERE c.part_id = ? ORDER BY c.compat_id""",
                (p["part_id"],),
            )
        ]
        dims = [
            dict(r)
            for r in con.execute(
                """SELECT d.dimension_type, d.value_mm, d.tolerance_mm, d.measured_by,
                          s.name AS source_name, s.url AS source_url
                   FROM part_dimensions d LEFT JOIN sources s USING (source_id)
                   WHERE d.part_id = ? ORDER BY d.dimension_id""",
                (p["part_id"],),
            )
        ]
        files = [
            dict(r)
            for r in con.execute(
                "SELECT file_type, file_url, version FROM part_files WHERE part_id = ?",
                (p["part_id"],),
            )
        ]
        flags = [
            dict(r)
            for r in con.execute(
                "SELECT jurisdiction, regulation_ref, notes FROM regulatory_flags WHERE part_id = ? AND applies = 1",
                (p["part_id"],),
            )
        ]
        parts.append(
            {
                "part_id": p["part_id"],
                "oem_part_number": p["oem_part_number"],
                "name": p["name"],
                "category": p["category"],
                "subcategory": p["subcategory"],
                "safety_class": p["safety_class"],
                "supply_status": p["supply_status"],
                "notes": p["notes"],
                "fits": fits,
                "dimensions": dims,
                "files": files,
                "flags": flags,
            }
        )
    return {"vehicles": vehicles, "parts": parts}


def build_html(data: dict) -> None:
    template = (ROOT / "template.html").read_text(encoding="utf-8")
    payload = json.dumps(data, ensure_ascii=False, indent=2).replace("</", "<\\/")
    HTML_PATH.write_text(template.replace("__DATA__", payload), encoding="utf-8")


if __name__ == "__main__":
    connection = build_db()
    exported = export_data(connection)
    build_html(exported)
    print(f"{DB_PATH.name}: {len(exported['vehicles'])} vehicles, {len(exported['parts'])} parts")
    print(f"{HTML_PATH.name}: generated")
    connection.close()
