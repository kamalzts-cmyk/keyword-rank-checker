# 🚀 Quick Setup Guide - Copy & Paste Only!

This guide is designed for complete beginners. Just copy and paste commands - that's it!

---

## **Step 1: Open Your Terminal**

### Windows Users:
1. Press `Windows Key + R`
2. Type `cmd` and press Enter
3. A black window opens ✅

### Mac Users:
1. Press `Command + Space`
2. Type `terminal` and press Enter
3. Terminal opens ✅

### Linux Users:
1. Press `Ctrl + Alt + T`
2. Terminal opens ✅

---

## **Step 2: Navigate to Your Desktop**

Copy and paste ONE of these commands based on your OS:

**Windows:**
```cmd
cd Desktop
```

**Mac/Linux:**
```bash
cd ~/Desktop
```

Press **Enter** and continue.

---

## **Step 3: Clone the Repository**

Copy and paste this:

```bash
git clone https://github.com/kamalzts-cmyk/keyword-rank-checker.git
```

Press **Enter** and wait for it to finish (you'll see download messages).

---

## **Step 4: Go Into the Project Folder**

Copy and paste:

```bash
cd keyword-rank-checker
```

Press **Enter**.

---

## **Step 5: Run the Complete Setup**

### For Windows (Command Prompt or PowerShell):
```cmd
bash setup.sh && pip install -r requirements.txt
```

### For Mac/Linux:
```bash
chmod +x setup.sh && ./setup.sh && pip install -r requirements.txt
```

Press **Enter** and watch it run! ✨

You'll see lots of text - that's normal! It's creating all your files.

---

## **Step 6: Get Your API Key (2 minutes)**

1. Open your web browser
2. Go to: **https://serper.dev/**
3. Click **"Sign Up"**
4. Use your Google account to sign up
5. Verify your email
6. Go to your dashboard
7. Copy your **API Key** (looks like: `abc123def456...`)
8. Keep this safe - you'll need it next

---

## **Step 7: Set Your API Key**

### For Windows (Command Prompt):
```cmd
setx SERPER_API_KEY "your_api_key_here"
```

**Replace `your_api_key_here` with your actual API key from Step 6**

Example:
```cmd
setx SERPER_API_KEY "1234567890abcdef1234567890abcdef"
```

Press **Enter**.

**Then close Command Prompt completely and open a NEW one.**

### For Mac/Linux:
```bash
export SERPER_API_KEY="your_api_key_here"
```

**Replace `your_api_key_here` with your actual API key**

Press **Enter**.

---

## **Step 8: Edit Your Keywords Configuration**

1. In the same terminal, type:
```bash
nano config.json
```
Press **Enter**.

2. You'll see the configuration file. Find the `keywords` section.

3. Replace the example keywords with YOUR keywords. For example:

```json
"keywords": [
  {
    "id": "kw_1",
    "keyword": "your keyword here",
    "target_url": "https://yourwebsite.com",
    "location": "US",
    "language": "en",
    "track": true
  }
]
```

4. When done editing:
   - Press `Ctrl + X` (or `Ctrl + O` on some systems)
   - Type `y` and press **Enter**
   - Press **Enter** again

5. You're back in the terminal ✅

---

## **Step 9: Test Your Agent (First Run)**

Copy and paste:

```bash
python main.py --check --report
```

Press **Enter**.

You'll see output like:
```
2024-01-15 10:30:45 - __main__ - INFO - Starting keyword ranking check...
2024-01-15 10:30:47 - src.rank_checker - INFO - Checking keyword: your keyword
Completed successfully
```

✅ **Success!** Your agent just ran!

---

## **Step 10: Check Your Reports**

In the terminal, type:

```bash
ls reports/
```

Press **Enter**.

You'll see files like:
```
ranking_report_20240115_103050.csv
ranking_report_20240115_103050.json
```

---

## **Step 11: View Your Report**

To see your CSV report (easiest to read):

```bash
cat reports/ranking_report_*.csv
```

Press **Enter**.

You'll see something like:
```
keyword,target_url,position,title,url,timestamp
your keyword,https://yourwebsite.com,5,Page Title,https://yourwebsite.com,2024-01-15 10:30:47
```

**What does "position: 5" mean?**
- Your website appears at position 5 in Google search results ✅
- Position 1-10 = Great!
- Position 11-100 = Good
- Position 0 = Not found yet

---

## **Step 12: Set Up Automation on GitHub**

Now your agent will check keywords automatically every day!

### 12a: Commit Your Changes

In terminal, copy and paste:

```bash
git add .
git commit -m "Configure keyword tracking"
git push origin main
```

Press **Enter** for each command.

### 12b: Add GitHub Secrets

1. Open your GitHub repository: https://github.com/kamalzts-cmyk/keyword-rank-checker
2. Click **Settings** (top menu)
3. Click **Secrets and variables** → **Actions** (left sidebar)
4. Click **New repository secret** (green button)

**Add Secret 1:**
- Name: `SERPER_API_KEY`
- Value: Your API key from Step 6
- Click **Add secret**

**Add Secret 2:**
- Name: `NOTIFICATION_EMAIL`
- Value: Your email
- Click **Add secret**

---

## **Step 13: Verify It Works Automatically**

1. Go to your GitHub repository
2. Click **Actions** tab
3. You should see "Daily Keyword Ranking Check"
4. Click it
5. Click **Run workflow** button (blue button)
6. Wait 2-3 minutes
7. Refresh and see the green checkmark ✅

---

## **🎉 You're Done!**

Your agent now:
- ✅ Checks your keywords automatically every day at 8 AM UTC
- ✅ Stores results in a database
- ✅ Generates reports (CSV & JSON)
- ✅ Tracks ranking changes over time

---

## **Useful Commands for Later**

**Check rankings manually:**
```bash
python main.py --check --report
```

**View latest rankings:**
```bash
cat reports/ranking_report_*.csv
```

**View logs:**
```bash
cat logs/rank_checker.log
```

**Add more keywords:**
1. Edit `config.json`
2. Add new keyword entries
3. Run: `python main.py --check --report`

---

## **❓ Troubleshooting**

### "git command not found"
- Download Git: https://git-scm.com/download/win (Windows) or `brew install git` (Mac)

### "Python not found"
- Download Python: https://www.python.org/downloads/
- **Important:** Check "Add Python to PATH" during installation

### "API key not working"
- Close and reopen terminal
- Verify key is set: `echo %SERPER_API_KEY%` (Windows) or `echo $SERPER_API_KEY` (Mac/Linux)

### "Permission denied"
- On Mac/Linux, run: `chmod +x setup.sh`

---

## **Need Help?**

If you get stuck:
1. Copy the error message
2. Try again following the steps
3. Ask me for help!

**Happy tracking! 🚀**
