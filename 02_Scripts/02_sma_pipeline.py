import pandas as pd
import matplotlib.pyplot as plt

# 1. Load Data
df = pd.read_csv('../01_Data/SPY_close_price_5Y.csv')
df['Date'] = pd.to_datetime(df['Date'])
df = df.sort_values('Date')

# 2. Calculate 50-Day SMA
df['SMA_50'] = df['Close'].rolling(window=50).mean()

# 3. Visualization
plt.figure(figsize=(12, 6))
plt.plot(df['Date'], df['Close'], label='SPY Close', alpha=0.5)
plt.plot(df['Date'], df['SMA_50'], label='50-Day SMA', color='orange', linewidth=2)
plt.title('SPY Close Price vs 50-Day SMA')
plt.legend()
plt.grid(True)

# 4. Save Output
plt.savefig('../03_Output/spy_sma_chart.png')
df.to_csv('../03_Output/spy_sma_calculated.csv', index=False)

print("Analysis Complete. Charts and Data saved to 03_Output/")