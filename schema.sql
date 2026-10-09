-- Schema for the discontinued-parts demo (IE / RHD pilot)
-- Same tables as the original design, plus one new column in parts: supply_status
-- (whether the part is still sold by the manufacturer, confirmed as discontinued, or not checked yet).

PRAGMA foreign_keys = ON;

CREATE TABLE manufacturers (
  manufacturer_id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  country TEXT,
  is_oem INTEGER DEFAULT 1
);

CREATE TABLE vehicles (
  vehicle_id INTEGER PRIMARY KEY AUTOINCREMENT,
  manufacturer_id INTEGER REFERENCES manufacturers(manufacturer_id),
  model TEXT NOT NULL,
  generation TEXT,
  platform_code TEXT,
  year_start INTEGER,
  year_end INTEGER,
  engine_code TEXT,
  body_type TEXT,
  market_region TEXT DEFAULT 'IE',
  drive_side TEXT CHECK (drive_side IN ('RHD','LHD')) DEFAULT 'RHD',
  tecdoc_ktype INTEGER
);

CREATE TABLE sources (
  source_id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  source_type TEXT,               -- 'marketplace_listing','community_forum','supplier_catalogue','aftermarket_catalogue','oem_dealer_catalogue','physical_scan'
  reliability_score INTEGER CHECK (reliability_score BETWEEN 1 AND 5),
  url TEXT
);

CREATE TABLE parts (
  part_id INTEGER PRIMARY KEY AUTOINCREMENT,
  oem_part_number TEXT,
  aftermarket_number TEXT,
  superseded_by_part_id INTEGER REFERENCES parts(part_id),
  name TEXT NOT NULL,
  category TEXT NOT NULL,         -- 'trim','clip','bracket','knob','housing'
  subcategory TEXT,
  material_original TEXT,
  safety_class TEXT NOT NULL CHECK (safety_class IN ('non_critical','regulated_cosmetic','excluded')),
  design_right_status TEXT CHECK (design_right_status IN ('must_match_exempt','protected','unknown')),
  supply_status TEXT NOT NULL DEFAULT 'unverified' CHECK (supply_status IN ('unverified','available_oem','nla_confirmed')),
  discontinued_since TEXT,
  manufacturer_id INTEGER REFERENCES manufacturers(manufacturer_id),
  notes TEXT
);

CREATE TABLE part_dimensions (
  dimension_id INTEGER PRIMARY KEY AUTOINCREMENT,
  part_id INTEGER REFERENCES parts(part_id),
  dimension_type TEXT NOT NULL,   -- 'length','width','height','diameter','thread_pitch'
  value_mm REAL NOT NULL,
  tolerance_mm REAL,
  measured_by TEXT,               -- 'caliper','3d_scan','oem_drawing'
  source_id INTEGER REFERENCES sources(source_id)
);

CREATE TABLE part_files (
  file_id INTEGER PRIMARY KEY AUTOINCREMENT,
  part_id INTEGER REFERENCES parts(part_id),
  file_type TEXT CHECK (file_type IN ('STL','STEP','OBJ','3MF')),
  file_url TEXT,
  scan_method TEXT,
  print_material_recommended TEXT,
  version INTEGER DEFAULT 1,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE part_vehicle_compatibility (
  compat_id INTEGER PRIMARY KEY AUTOINCREMENT,
  part_id INTEGER REFERENCES parts(part_id),
  vehicle_id INTEGER REFERENCES vehicles(vehicle_id),
  fitment_position TEXT,
  confidence TEXT CHECK (confidence IN ('oem_confirmed','tecdoc_confirmed','aftermarket_catalogue','community_reported','inferred')),
  verified_by TEXT,
  verified_at TEXT,
  source_id INTEGER REFERENCES sources(source_id),
  UNIQUE(part_id, vehicle_id, fitment_position)
);

CREATE TABLE regulatory_flags (
  flag_id INTEGER PRIMARY KEY AUTOINCREMENT,
  part_id INTEGER REFERENCES parts(part_id),
  jurisdiction TEXT,
  regulation_ref TEXT,
  applies INTEGER,
  notes TEXT
);
