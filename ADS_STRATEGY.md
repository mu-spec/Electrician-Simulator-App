# VoltMaster Pro — Ads Strategy (from competitor review)

## Competitors reviewed

### 1) Electrician Handbook (`mmy.first.myapplication433`) — SVA APPS
- **10M+** downloads, **4.7★**, In-app purchases
- Same product shape as VoltMaster: Theory · Diagrams · Quiz · Calculators
- Play listing / data safety indicates **analytics + ads-related device/app data**
- Monetization model: **Ads + IAP (remove ads / premium style common in this niche)**

### 2) Electricians' Handbook (`calculation.world.electricianshandbook`) — Calculation World
- **1M+** downloads, **4.6★**, **Contains ads**, In-app purchases
- Same 4 pillars: Theory · Calculators · Wiring diagrams · Quizzes
- Explicit **Contains ads** badge on Play Store

## How these apps typically use ads (industry pattern for this niche)

Play pages do not expose exact unit IDs, but successful electrician apps in this category almost always use:

| Ad type | Typical placement | Why |
|---------|-------------------|-----|
| **Banner** | Sticky bottom (above or below nav) on main tabs | High impressions, low friction |
| **Interstitial** | After calculator result, after quiz, between content opens | Natural break points, higher eCPM |
| **Optional later** | Rewarded for unlocks / remove-ads IAP | Better UX + revenue mix |

## Best placements in **VoltMaster Pro**

### Banner ads (best)
1. **Main shell above bottom navigation** (IMPLEMENTED)
   - Home / Theory / Calculators / Wiring / Quiz all share one sticky banner
   - Matches competitor “always-on” monetization without covering content body

Optional later banners (not implemented yet):
- Theory list bottom (only if main banner removed)
- Calculator list bottom
- Avoid banners inside article reading body or diagram zoom viewer

### Interstitial ads (best)
Implemented with **frequency caps** so UX stays professional:

| Trigger | Rule | Why best |
|---------|------|----------|
| **After successful Calculate** | Every **2nd** calculation | High intent moment; user already finished action |
| **After quiz finished** | **Always once** before results | Clear session break (competitors do this) |
| **Open theory / wiring detail** | Every **3rd** open | Content browsing monetization without every tap |
| Global cooldown | Min **45 seconds** between interstitials | Prevents spam / policy risk |

### Where **NOT** to put interstitials
- App cold start / splash (bad UX + policy risk)
- Every bottom-nav tab switch
- While reading mid-article scroll
- During live diagram zoom / resistor tool precision work
- Settings / language / feedback (trust screens)

## Test IDs currently in app (Google official samples)

| Use | ID |
|-----|----|
| Android App ID | `ca-app-pub-3940256099942544~3347511713` |
| Banner | `ca-app-pub-3940256099942544/6300978111` |
| Interstitial | `ca-app-pub-3940256099942544/1033173712` |

Files:
- `lib/core/ads/ad_helper.dart`
- `lib/core/ads/ad_service.dart`
- `lib/core/ads/banner_ad_widget.dart`
- `android/app/src/main/AndroidManifest.xml` (APPLICATION_ID meta-data)
- `pubspec.yaml` → `google_mobile_ads`

## Production checklist
1. Create real AdMob app + ad units
2. Replace IDs in `ad_helper.dart` + AndroidManifest
3. Add iOS `GADApplicationIdentifier` in `Info.plist` when shipping iOS
4. Update Privacy Policy + Play Data safety (Ads)
5. Optional: Add “Remove Ads” IAP like competitors
6. Keep frequency caps (do not show interstitial every action)

## Expected UX in VoltMaster after this change
- Banner appears above bottom tabs when loaded
- Interstitial may appear after calculate (2nd), quiz end, or every 3rd theory/wiring open
- Uses **test ads only** until you swap IDs

## App Open + Rewarded (added carefully)

### App Open (test unit `.../9257395921`)
| Trigger | Careful rule |
|---------|----------------|
| Cold start after splash | Wait max ~1.2s for ad; never block forever |
| Resume from background | Only if app was backgrounded **≥ 30 minutes** |
| Cooldown | Max **1 app-open every 4 hours** |
| Skipped when | Ads-free reward active, another fullscreen showing, ad not ready |

### Rewarded (test unit `.../5224354917`)
| Place | Reward |
|-------|--------|
| **Settings → Ads** | Watch ad → **remove banner/interstitial/app-open for 24 hours** |
| **Quiz results** | Optional **Watch Ad to Retry Free** (opt-in; free Retry still available) |

Rewarded is always user-initiated (never forced).