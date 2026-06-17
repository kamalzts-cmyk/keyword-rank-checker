#!/bin/bash

# Keyword Ranking Checker - Quick Setup
# Ultra-simple one-command setup!

echo ""
echo "╔════════════════════════════════════════════════════════╗"
echo "║   Keyword Ranking Checker - Quick Setup                ║"
echo "╚════════════════════════════════════════════════════════╝"
echo ""

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_status() { echo -e "${BLUE}[*]${NC} $1"; }
print_success() { echo -e "${GREEN}[✓]${NC} $1"; }

print_status "Creating directories..."
mkdir -p src tests .github/workflows reports logs data
print_success "Directories created"

print_status "Creating Python modules..."
echo ""

# Create all files
cat > src/__init__.py << 'EOF'
"""Keyword Rank Checker"""
__version__ = '1.0.0'
EOF

cat > src/rank_checker.py << 'EOF'
import logging
import requests
from typing import Dict
logger = logging.getLogger(__name__)
class RankChecker:
    def __init__(self, api_config: Dict):
        self.provider = api_config.get('provider', 'serper')
        self.api_key = api_config.get('serper_api_key')
        self.max_results = api_config.get('max_results', 100)
        self.timeout = api_config.get('timeout', 30)
    def check_keyword(self, keyword: str, target_url: str, location: str = 'US', language: str = 'en') -> Dict:
        logger.info(f"Checking: {keyword}")
        return self._check_with_serper(keyword, target_url, location, language)
    def _check_with_serper(self, keyword: str, target_url: str, location: str, language: str) -> Dict:
        url = "https://google.serper.dev/search"
        payload = {"q": keyword, "gl": location.lower(), "hl": language, "num": 100}
        headers = {"X-API-KEY": self.api_key, "Content-Type": "application/json"}
        try:
            response = requests.post(url, json=payload, headers=headers, timeout=self.timeout)
            response.raise_for_status()
            data = response.json()
            results = data.get('organic', [])
            position = 0
            for idx, result in enumerate(results, 1):
                if self._url_match(result.get('link', ''), target_url):
                    position = idx
                    break
            return {'keyword': keyword, 'target_url': target_url, 'position': position, 'url': results[position-1].get('link') if position > 0 else '', 'title': results[position-1].get('title') if position > 0 else ''}
        except Exception as e:
            logger.error(f"Error: {e}")
            raise
    def _url_match(self, result_url: str, target_url: str) -> bool:
        result_domain = result_url.replace('https://', '').replace('http://', '').split('/')[0]
        target_domain = target_url.replace('https://', '').replace('http://', '').split('/')[0]
        return result_domain == target_domain
EOF

cat > src/database.py << 'EOF'
import sqlite3
import logging
from datetime import datetime, timedelta
from typing import Dict, List, Optional
from pathlib import Path
logger = logging.getLogger(__name__)
class Database:
    def __init__(self, db_config: Dict):
        self.db_path = db_config.get('path', './data/rankings.db')
        Path(self.db_path).parent.mkdir(parents=True, exist_ok=True)
        self._init_db()
    def _init_db(self):
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS rankings (
                id INTEGER PRIMARY KEY, keyword TEXT, target_url TEXT, position INTEGER,
                url TEXT, title TEXT, timestamp DATETIME DEFAULT CURRENT_TIMESTAMP)
        ''')
        conn.commit()
        conn.close()
    def store_ranking(self, keyword: str, target_url: str, position: int, url: str = '', title: str = '') -> int:
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        cursor.execute('INSERT INTO rankings (keyword, target_url, position, url, title) VALUES (?, ?, ?, ?, ?)',
                      (keyword, target_url, position, url, title))
        conn.commit()
        row_id = cursor.lastrowid
        conn.close()
        return row_id
    def get_latest_rankings(self) -> List[Dict]:
        conn = sqlite3.connect(self.db_path)
        conn.row_factory = sqlite3.Row
        cursor = conn.cursor()
        cursor.execute('SELECT * FROM rankings WHERE (keyword, timestamp) IN (SELECT keyword, MAX(timestamp) FROM rankings GROUP BY keyword) ORDER BY keyword')
        results = [dict(row) for row in cursor.fetchall()]
        conn.close()
        return results
EOF

cat > src/report_generator.py << 'EOF'
import json
import csv
import logging
from datetime import datetime
from pathlib import Path
from typing import Dict, List
logger = logging.getLogger(__name__)
class ReportGenerator:
    def __init__(self, report_config: Dict):
        self.output_dir = Path(report_config.get('output_dir', './reports'))
        self.output_dir.mkdir(exist_ok=True)
    def generate(self, latest_rankings: List[Dict], timestamp: datetime) -> Dict:
        return {'timestamp': timestamp.isoformat(), 'rankings': latest_rankings}
    def export(self, report: Dict, format: str) -> Path:
        timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        if format == 'json':
            filename = self.output_dir / f"report_{timestamp}.json"
            with open(filename, 'w') as f:
                json.dump(report, f, indent=2, default=str)
        elif format == 'csv':
            filename = self.output_dir / f"report_{timestamp}.csv"
            with open(filename, 'w', newline='') as f:
                writer = csv.DictWriter(f, fieldnames=['keyword', 'target_url', 'position', 'url', 'timestamp'])
                writer.writeheader()
                for r in report.get('rankings', []):
                    writer.writerow(r)
        return filename
EOF

cat > src/notifier.py << 'EOF'
import logging
from typing import Dict, List
logger = logging.getLogger(__name__)
class Notifier:
    def __init__(self, config: Dict):
        self.enabled = config.get('enabled', True)
    def notify_results(self, results: List[Dict]) -> bool:
        if self.enabled:
            logger.info(f"Notification: Checked {len(results)} keywords")
        return True
EOF

cat > tests/__init__.py << 'EOF'
"""Tests"""
EOF

cat > requirements.txt << 'EOF'
requests==2.31.0
pandas==2.1.3
python-dotenv==1.0.0
pytest==7.4.3
EOF

cat > config.json << 'EOF'
{
  "keywords": [
    {"id": "kw_1", "keyword": "best python tutorials", "target_url": "https://example.com", "location": "US", "language": "en", "track": true},
    {"id": "kw_2", "keyword": "python web development", "target_url": "https://example.com", "location": "US", "language": "en", "track": true}
  ],
  "api_config": {"provider": "serper", "serper_api_key": "${SERPER_API_KEY}", "max_results": 100},
  "database": {"type": "sqlite", "path": "./data/rankings.db"},
  "reporting": {"output_dir": "./reports", "export_formats": ["json", "csv"]},
  "notifications": {"enabled": true, "email": "${NOTIFICATION_EMAIL}"}
}
EOF

cat > main.py << 'EOF'
#!/usr/bin/env python3
import argparse, logging, json, os
from datetime import datetime
from pathlib import Path
from src.rank_checker import RankChecker
from src.database import Database
from src.report_generator import ReportGenerator
from src.notifier import Notifier
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[logging.FileHandler('logs/rank_checker.log'), logging.StreamHandler()])
logger = logging.getLogger(__name__)
def load_config(path='config.json'):
    try:
        with open(path) as f:
            config = json.load(f)
        if os.getenv('SERPER_API_KEY'):
            config['api_config']['serper_api_key'] = os.getenv('SERPER_API_KEY')
        return config
    except FileNotFoundError:
        logger.error(f"Config not found: {path}")
        return {}
def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--check', action='store_true')
    parser.add_argument('--report', action='store_true')
    args = parser.parse_args()
    Path('logs').mkdir(exist_ok=True)
    Path('data').mkdir(exist_ok=True)
    Path('reports').mkdir(exist_ok=True)
    config = load_config()
    if not config:
        return 1
    if args.check or not args.report:
        logger.info("Starting ranking check...")
        db = Database(config['database'])
        checker = RankChecker(config['api_config'])
        keywords = config.get('keywords', [])
        for kw in keywords:
            if kw.get('track'):
                try:
                    result = checker.check_keyword(kw['keyword'], kw['target_url'], kw.get('location', 'US'))
                    db.store_ranking(kw['keyword'], kw['target_url'], result['position'], result['url'], result['title'])
                    logger.info(f"Position: {result['position']} for {kw['keyword']}")
                except Exception as e:
                    logger.error(f"Error: {e}")
    if args.report:
        db = Database(config['database'])
        gen = ReportGenerator(config['reporting'])
        latest = db.get_latest_rankings()
        report = gen.generate(latest, datetime.now())
        for fmt in config['reporting']['export_formats']:
            gen.export(report, fmt)
            logger.info(f"Report exported: {fmt}")
    logger.info("Done!")
    return 0
if __name__ == '__main__':
    exit(main())
EOF
chmod +x main.py

cat > .github/workflows/daily-ranking-check.yml << 'EOF'
name: Daily Keyword Ranking Check
on:
  schedule:
    - cron: '0 8 * * *'
  workflow_dispatch:
jobs:
  check:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-python@v4
        with:
          python-version: '3.11'
      - run: pip install -r requirements.txt
      - run: python main.py --check --report
        env:
          SERPER_API_KEY: ${{ secrets.SERPER_API_KEY }}
EOF

cat > .gitignore << 'EOF'
__pycache__/
*.py[cod]
venv/
.venv
data/*.db
logs/*.log
reports/*
!reports/.gitkeep
.env
.DS_Store
EOF

touch reports/.gitkeep logs/.gitkeep data/.gitkeep

print_success "All files created!"
echo ""
echo -e "${GREEN}✓ Setup Complete!${NC}"
echo ""
echo -e "${BLUE}Next Steps:${NC}"
echo "1. Edit config.json with your keywords"
echo "2. Get API key from https://serper.dev/"
echo "3. Set: export SERPER_API_KEY=your_key (Mac/Linux) or setx SERPER_API_KEY your_key (Windows)"
echo "4. Run: python main.py --check --report"
echo "5. Check reports in reports/ folder"
echo ""
echo -e "${YELLOW}For detailed help, see SETUP_GUIDE.md${NC}"
echo -e "${GREEN}Happy tracking! 🚀${NC}"
echo ""
