# Revora: discontinued trim parts demo (IE / RHD pilot)

A small SQLite database plus a lookup page that works offline. Built to show the concept at the Auto Trade EXPO (Dublin, 10-11 Oct 2026).

The pilot idea: simple parts whose **dimensions are already published**, so they can be modelled without scanning.

## Files

| File | What it is |
|---|---|
| `index.html` | The lookup page. A single file, no internet needed. Opens on a phone or tablet. |
| `pecas_ie.db` | The SQLite database (opens in DBeaver). |
| `schema.sql` | Tables. Same design as the original schema, with `supply_status` in `parts` and the `aftermarket_catalogue` confidence level. |
| `seed.sql` | The pilot data: 4 models, 10 parts, with the source of every dimension and every fitment. |
| `template.html` | Page template. `build.py` injects the database data into it. |
| `build.py` | Rebuilds the `.db` and `index.html`. Python standard library only. |

## At the fair

1. Copy `index.html` to the tablet or phone and open it in the browser (works in airplane mode).
2. Test it the night before on the device you will bring. So far it has only been tested automatically, not on a real tablet.
3. Use the page as a hook for the interview script: "have you ever looked for one of these clips and not found it?".

## Rebuild after changing the data

```bash
python3 build.py
```

To add a part: edit `seed.sql` (`parts`, `part_vehicle_compatibility`, `sources` and `part_dimensions`) and run the build. The page shows the measurements from `part_dimensions` automatically.

## Open in DBeaver

New Database Connection > SQLite > Path: `pecas_ie.db`.

## Publish an online version (optional)

Since the repository is public, `index.html` can be served with GitHub Pages: Settings > Pages > Source: "Deploy from a branch" > branch `main`, folder `/ (root)`. The address will be `https://bentjul-eng.github.io/revora-automotive-eng/` after a few minutes. Useful for a QR code, but use the local copy at the fair, because the wifi may fail.

## Where the data comes from

- **Dimensions**: supplier catalogues (Lawson, Kimball Midwest, Kent Automotive), which have full tables per OEM number; eBay/Walmart listings, which are approximate; and a forum post by an Avensis owner. Each measurement stores its source and type (`seller_listing_approx`, `supplier_catalogue`, `forum_post`).
- **Fitment**: `aftermarket_catalogue` when a parts catalogue names the model; `community_reported` when a listing or forum names it; `inferred` when it is only deduced.
- **Caution**: Lawson, Kimball and Kent are **US** catalogues and list US model years. The car sold in Ireland (RHD) may use a different clip. No fitment has been verified on an Irish car.
- `supply_status` is `unverified` for all parts. They all still show up for sale as replacements, so discontinuation is a hypothesis to test.
- 3D files: none made yet.
- `design_right_status` is `unknown` for all parts. It is a legal question and should not be filled in without review.
- The Yaris is in the demo because of the data, but its volume in the Irish fleet has not been checked. The Focus was Ireland's best-selling car in 2005-2009; the Corolla and Avensis were in the top three in 2007 and 2008.

## Candidates left out

No published dimensions, or a shape too complex. They only go in with a CAD file or a scan:

- Focus Mk2: `4M51-16613-AC`, `4M51-A24049-ACW`, `4M51-22642-ADW`, `3M51-226A37`
- Corolla E120/E150: `87945-05901`, `87915-05901` (mirror covers), `90467-10167`, `90467-06049-22`

No confirmed fitment on any of the models: `90467-07211` (grille clip, only the head has a measurement).
