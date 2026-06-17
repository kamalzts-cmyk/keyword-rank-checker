# 🎯 Your First Run - Simple 3-Step Guide

## **Step 1: Get Your API Key** (2 minutes)

1. Go to: https://serper.dev/
2. Sign up with Google
3. Verify email
4. Get your API key from dashboard
5. Keep it safe

---

## **Step 2: Set Your API Key** (1 minute)

### Windows Users:
```cmd
setx SERPER_API_KEY "your_api_key_here"
```

**Then close and open a NEW Command Prompt**

### Mac/Linux Users:
```bash
export SERPER_API_KEY="5bb6f1b1d3f84b2913471992044346853327a449"
```

---

## **Step 3: Edit Your Keywords**

Open `config.json` and find the `keywords` section. Replace with YOUR keywords:

```json
"keywords": [
  {
    "id": "kw_1",
    "keyword": "Diagnostic Test Kit for Medical Use
Medical Testing Kits
Diagnostic Test Kit Online
Online Diagnostic Test Kit
Rapid Antigen Test Kit Online
Antigen Rapid Test Kit
Antigen Rapid Test Kit Online
Blood Group Test Device
Blood Group Test Kit Online
Rapid Blood Type Test Kit
Reagent Test Kit Online
CRP Rapid Test Kit
CRP Testing Kit Online
Online Test Kit for CRP
Rapid Testing Kits for CRP
CRP Rapid Test at Home
Igg Igm Rapid Test Kit
IgM Antibodies Test
Blood Test Kit for Igg
Covid 19 Sars Cov 2 Antibody Test Kit
Rapid Diagnostic Tests for Infectious Diseases
Rapid Malaria Test Kit
Influenza Rapid Test Kit
Influenza Test Kit Uk
Influenza Ab Rapid Test
Rapid Influenza Test Kit
Rapid Flu Test at Home
Malaria Antibody Test Kit
Gluten Check Test Kit
Blood Test Kit for Coeliac Disease
Celiac Disease Antibody Testing
Sars Cov 2 Antigen Rapid Test Kit
Sars Cov2 Antigen Rapid Test
Sars Cov 2 Rapid Antigen Test
Alere Hcg Test
Alere Hcg Test Kits
Hcg Count for Pregnancy
Alere Pregnancy Test
Abbott Drug Test
Plasma Rapid Testing
Plasma Rapid Test Online
D Dimer Test Buy Online
Test Kit for D Dimer
Neutralising Antibodies Test
Neutralising Antibodies Test Kits
Myoglobin Test Kit
Troponin Test Kit Online
Troponin T Rapid Test Kit
New keyword
Typhoid Antigen Rapid Test
Dengue NS1 Antigen Rapid Test
blood type test reagent
RSV diagnostic test
test kit for blood type
Abbott Oral Fluid Testing
blood type test kit
blood type testing kit
Abbott Oral Fluid Testing Drug
Abbott Saliva Drug Test
Abbott Oral Fluid Test
Abbott COVID-19 Flow Test
RSV Antigen Test Kit
AB0 Antigen Determination kit
Reagents Antigen Test Kit
Rapid Fob test Kit",
    "target_url": "(https://poc-diagnostics.co.uk/)",
    "location": "US",
    "language": "en",
    "track": true
  }
]
```

Example:
```json
"keywords": [
  {
    "id": "kw_1",
    "keyword": "learn python",
    "target_url": "https://mypythonsite.com",
    "location": "US",
    "language": "en",
    "track": true
  },
  {
    "id": "kw_2",
    "keyword": "web development tutorial",
    "target_url": "https://mypythonsite.com/web",
    "location": "US",
    "language": "en",
    "track": true
  }
]
```

---

## **Step 4: Run Your First Check!**

In terminal, run:

```bash
python main.py --check --report
```

You'll see:
```
2024-01-15 10:30:45 - __main__ - INFO - Starting keyword ranking check...
2024-01-15 10:30:47 - src.rank_checker - INFO - Checking keyword: learn python
2024-01-15 10:30:50 - src.database - INFO - Stored ranking: learn python at position 12
Completed successfully
```

✅ Success!

---

## **Step 5: Check Your Report**

In terminal:

```bash
cat reports/ranking_report_*.csv
```

You'll see:
```
keyword,target_url,position,title,url,timestamp
learn python,https://mypythonsite.com,12,Python Tutorial,https://mypythonsite.com,2024-01-15 10:30:47
```

**Position 12 = Your site is #12 on Google for "learn python" ✅**

---

## **Understanding Positions**

| Position | Meaning |
|----------|----------|
| 1-3 | 🚀 Excellent! |
| 4-10 | ✅ Good |
| 11-50 | 📈 Decent |
| 51-100 | 🔄 Keep working |
| 0 | ❌ Not in top 100 |

---

## **Step 6: Set Up Automation**

So your agent checks keywords automatically every day:

### 6a: Commit Changes
```bash
git add .
git commit -m "Configure keywords"
git push origin main
```

### 6b: Add GitHub Secrets

1. Go to: https://github.com/kamalzts-cmyk/keyword-rank-checker
2. Click **Settings**
3. Click **Secrets and variables** → **Actions**
4. Click **New repository secret**
5. Add `SERPER_API_KEY` with your API key value
6. Add `NOTIFICATION_EMAIL` with your email

---

## **Step 7: Verify Automation**

1. Go to your GitHub repo
2. Click **Actions** tab
3. Click **Daily Keyword Ranking Check**
4. Click **Run workflow** (blue button)
5. Wait 2-3 minutes
6. See green checkmark ✅

---

## **Now It Runs Automatically!**

✅ Every day at 8 AM UTC
✅ Checks your keywords
✅ Stores results
✅ Generates reports
✅ You can see trends over time

---

## **Useful Commands**

```bash
# Manual check
python main.py --check --report

# View latest report
cat reports/ranking_report_*.csv

# View logs
cat logs/rank_checker.log

# Add more keywords
# Edit config.json, then run:
python main.py --check --report
```

---

## **Troubleshooting**

### "API key not working"
```bash
# Check if set correctly
echo %SERPER_API_KEY%  # Windows
echo $SERPER_API_KEY  # Mac/Linux
```

### "Module not found"
```bash
pip install -r requirements.txt
```

### "Permission denied" (Mac/Linux)
```bash
chmod +x main.py
```

---

## **Need More Keywords?**

Edit `config.json` and add more entries:

```json
"keywords": [
  { "keyword": "keyword 1", "target_url": "...", ... },
  { "keyword": "keyword 2", "target_url": "...", ... },
  { "keyword": "keyword 3", "target_url": "...", ... }
]
```

Then run: `python main.py --check --report`

---

## **Questions?**

Check `SETUP_GUIDE.md` for detailed help.

**Happy tracking! 🎉**
