-- Pilot dataset v3: Toyota (Corolla, Avensis, Yaris) + 1 Focus part.
-- The Toyota 90467-xxxxx clips are shared across models and have dimension tables
-- in supplier catalogues (Lawson, Kimball Midwest, Kent Automotive).
-- supply_status = 'unverified' for all: every one still shows up for sale as a replacement.

INSERT INTO manufacturers (manufacturer_id, name, country, is_oem) VALUES
  (1, 'Ford',   'US', 1),
  (2, 'Toyota', 'JP', 1);

INSERT INTO vehicles (vehicle_id, manufacturer_id, model, generation, year_start, year_end, market_region, drive_side) VALUES
  (1, 1, 'Focus',   'Mk2',       2004, 2011, 'IE', 'RHD'),
  (2, 2, 'Corolla', 'E120/E150', 2002, 2013, 'IE', 'RHD'),
  (3, 2, 'Avensis', 'T25',       2003, 2008, 'IE', 'RHD'),
  (4, 2, 'Yaris',   'XP90',      2005, 2011, 'IE', 'RHD');

INSERT INTO sources (source_id, name, source_type, reliability_score, url) VALUES
  (1,  'Walmart listing: Ford emblem mounting kit (OEM 1505788, 1125799)',          'marketplace_listing',   2, 'https://www.walmart.com/ip/7708612911'),
  (2,  'Walmart listing: door trim clips replacing Toyota 90467-10188',              'marketplace_listing',   2, 'https://www.walmart.com/ip/446856359'),
  (3,  'eBay.de listing: Toyota 90467-10183 clips, 7 mm holes only',                 'marketplace_listing',   2, 'https://www.ebay.de/itm/405393618985'),
  (4,  'eBay.de listing: fender retainer clips for Corolla 1999-2012 (90467-10183)', 'marketplace_listing',   2, 'https://www.ebay.de/itm/304547409201'),
  (5,  'Oscaro catalogue: trim clips for Toyota Avensis (T25) estate',               'aftermarket_catalogue', 3, 'https://www.oscaro.com/clip-enjoliveur-toyota-avensis-t25-break-2-0-d-4d-116cv-3881-12986-0-gt'),
  (6,  'Lawson Products: trim board retainer for Toyota (90467-10161)',              'supplier_catalogue',    4, 'https://www.lawsonproducts.com/products/trim-board-retainer-nylon-13mm-p23177'),
  (7,  'Toyota Owners Club forum: Avensis engine under cover clip',                  'community_forum',       2, 'https://toyotaownersclub.com/forums/topic/120647-engine-under-cover-clip'),
  (8,  'Kimball Midwest: door moulding retainer with sealer (90467-10077)',          'supplier_catalogue',    4, 'https://www.kimballmidwest.com/131109'),
  (9,  'Kimball Midwest: bumper fascia retainer (90467-05090-B1)',                    'supplier_catalogue',    4, 'https://www.kimballmidwest.com/13794'),
  (10, 'Kent Automotive: push-type retainer 19 mm (90467-07217)',                    'supplier_catalogue',    4, 'https://kent-automotive.com/products/push-type-retainer-nylon-19mm-1536737'),
  (11, 'Kimball Midwest: bumper retainer 7 mm x 14 mm (90467-07071-22)',             'supplier_catalogue',    4, 'https://www.kimballmidwest.com/13799'),
  (12, 'Kimball Midwest: fender seal retainer (90467-08136)',                        'supplier_catalogue',    4, 'https://www.kimballmidwest.com/13800');

INSERT INTO parts (part_id, oem_part_number, name, category, subcategory, safety_class, design_right_status, supply_status, manufacturer_id, notes) VALUES
  (1,  '1505788 / 1125799', 'Emblem mounting clip (tilting badge)', 'clip', 'emblem mount', 'non_critical', 'unknown', 'unverified', 1,
       'The seller says the kit also fits the Focus II facelift, C-Max, Mondeo, Kuga and Transit Connect. The kit includes a metal spring, so only the plastic clip would be printed. Whether it is the front or rear badge is not stated.'),
  (2,  '90467-10188', 'Door trim panel clip', 'clip', 'trim fastener', 'non_critical', 'unknown', 'unverified', 2,
       'The listing is for a replacement clip that cross-references this OEM number and lists Corolla 1998-2015. The figures are the seller''s approximate ones.'),
  (3,  '90467-10183', 'Fender retainer clip, 7 mm hole', 'clip', 'trim fastener', 'non_critical', 'unknown', 'unverified', 2,
       'Seller listings say it fits Corolla 1999-2012 and holes of 7 mm. An Avensis T25 parts catalogue lists a clip with this OEM reference. Head and stem sizes were not given in the sources found.'),
  (4,  '90467-10077', 'Door moulding retainer with sealer', 'clip', 'trim fastener', 'non_critical', 'unknown', 'unverified', 2,
       'US supplier catalogue; it lists Corolla 1998-on, which is a US year range. Check against the Irish-market car.'),
  (5,  '90467-05090-B1', 'Bumper fascia retainer', 'clip', 'trim fastener', 'non_critical', 'unknown', 'unverified', 2,
       'US supplier catalogue; it lists Corolla, Matrix and Scion 2008-on for the front bumper fascia. Check against the Irish-market E150.'),
  (6,  '90467-07217', 'Push-type retainer, 19 mm head', 'clip', 'trim fastener', 'non_critical', 'unknown', 'unverified', 2,
       'US supplier catalogue; it lists Corolla and Yaris 2010-on, among other Toyota and Lexus models. Check against the Irish-market cars.'),
  (7,  '90467-10161', 'Trim panel retainer (stepped head)', 'clip', 'trim fastener', 'non_critical', 'unknown', 'unverified', 2,
       'Dimensions are from a US supplier catalogue that lists Sienna, Solara and Tercel. The Avensis T25 link comes from a separate parts catalogue that cross-references this OEM number.'),
  (8,  '90467-07201', 'Engine under cover clip', 'clip', 'underbody fastener', 'non_critical', 'unknown', 'unverified', 2,
       'Dimensions and fitment come from one owner''s forum post, with the clip priced around 1.50 pounds each.'),
  (9,  '90467-07071-22', 'Bumper retainer, 7 mm hole', 'clip', 'trim fastener', 'non_critical', 'unknown', 'unverified', 2,
       'US supplier catalogue; it lists Yaris 2009-on. Check against the Irish-market XP90.'),
  (10, '90467-08136', 'Fender seal retainer', 'clip', 'trim fastener', 'non_critical', 'unknown', 'unverified', 2,
       'US supplier catalogue; it lists Yaris 2009-on. Check against the Irish-market XP90.');

INSERT INTO part_vehicle_compatibility (part_id, vehicle_id, fitment_position, confidence, source_id) VALUES
  (1,  1, 'Badge mount (position to be confirmed)',  'community_reported',    1),
  (2,  2, 'Door trim panels',                        'community_reported',    2),
  (3,  2, 'Front fender',                            'community_reported',    4),
  (3,  3, 'Trim or moulding (position to be confirmed)', 'aftermarket_catalogue', 5),
  (4,  2, 'Door moulding, with sealer',              'aftermarket_catalogue', 8),
  (5,  2, 'Front bumper fascia',                     'aftermarket_catalogue', 9),
  (6,  2, 'Push-type retainer (position to be confirmed)', 'aftermarket_catalogue', 10),
  (6,  4, 'Push-type retainer (position to be confirmed)', 'aftermarket_catalogue', 10),
  (7,  3, 'Trim panels (position to be confirmed)',  'aftermarket_catalogue', 5),
  (8,  3, 'Engine under cover',                      'community_reported',    7),
  (9,  4, 'Bumper',                                  'aftermarket_catalogue', 11),
  (10, 4, 'Fender seal',                             'aftermarket_catalogue', 12);

INSERT INTO part_dimensions (part_id, dimension_type, value_mm, measured_by, source_id) VALUES
  (1,  'clip_max_diameter',     18,   'seller_listing_approx', 1),
  (1,  'spring_length',         49,   'seller_listing_approx', 1),
  (1,  'spring_outer_diameter', 18,   'seller_listing_approx', 1),
  (1,  'spring_inner_diameter', 16.5, 'seller_listing_approx', 1),
  (2,  'head_diameter_max',     18,   'seller_listing_approx', 2),
  (2,  'stem_length',           14,   'seller_listing_approx', 2),
  (2,  'hole_diameter_max',     9,    'seller_listing_approx', 2),
  (3,  'hole_diameter',         7,    'seller_listing_approx', 3),
  (4,  'head_diameter',         15,   'supplier_catalogue',    8),
  (4,  'stem_length',           9,    'supplier_catalogue',    8),
  (4,  'hole_diameter',         8,    'supplier_catalogue',    8),
  (5,  'head_diameter',         10,   'supplier_catalogue',    9),
  (5,  'stem_length',           12,   'supplier_catalogue',    9),
  (5,  'hole_diameter',         5,    'supplier_catalogue',    9),
  (6,  'head_diameter',         19,   'supplier_catalogue',    10),
  (6,  'stem_length',           9,    'supplier_catalogue',    10),
  (6,  'hole_diameter',         7,    'supplier_catalogue',    10),
  (7,  'head_diameter_top',     13,   'supplier_catalogue',    6),
  (7,  'head_diameter_middle',  16,   'supplier_catalogue',    6),
  (7,  'head_diameter_bottom',  18,   'supplier_catalogue',    6),
  (7,  'stem_width',            9,    'supplier_catalogue',    6),
  (7,  'stem_depth',            9,    'supplier_catalogue',    6),
  (7,  'stem_length',           14,   'supplier_catalogue',    6),
  (7,  'overall_length',        20,   'supplier_catalogue',    6),
  (7,  'hole_diameter',         9,    'supplier_catalogue',    6),
  (8,  'head_diameter',         20,   'forum_post',            7),
  (8,  'stem_length',           10,   'forum_post',            7),
  (8,  'stem_diameter',         7,    'forum_post',            7),
  (9,  'head_diameter',         11,   'supplier_catalogue',    11),
  (9,  'stem_length',           14,   'supplier_catalogue',    11),
  (9,  'hole_diameter',         7,    'supplier_catalogue',    11),
  (10, 'head_diameter',         20,   'supplier_catalogue',    12),
  (10, 'stem_length',           8,    'supplier_catalogue',    12),
  (10, 'stem_diameter',         8,    'supplier_catalogue',    12),
  (10, 'hole_diameter',         7,    'supplier_catalogue',    12);
