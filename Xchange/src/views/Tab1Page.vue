<template>
  <ion-page>
    <ion-header>
      <ion-toolbar>
        <ion-title>Doustor</ion-title>
      </ion-toolbar>
    </ion-header>
    <ion-content :fullscreen="true">
      <ion-header collapse="condense">
        <ion-toolbar>
          <ion-title size="large">Finance Swap</ion-title>
        </ion-toolbar>
      </ion-header>

      <div class="swap-shell">
        <ion-card>
          <div class="hero-banner">
            <div>
              <p class="eyebrow">Smart routing</p>
              <h2>Swap</h2>
            </div>
            <span class="pill">Live quote</span>
          </div>
          <ion-card-header>
            <ion-card-title>Build a quote in seconds</ion-card-title>
            <ion-card-subtitle>Compare best routes with a polished, mobile-first experience.</ion-card-subtitle>
          </ion-card-header>
          <ion-card-content>
            <div class="field-group">
              <label for="amount">Amount</label>
              <input id="amount" v-model="amount" placeholder="Enter amount" type="number" min="0" step="0.01" />
            </div>
            <div class="field-group">
              <label for="from-token">From token address</label>
              <input id="from-token" v-model="fromTokenAddress" placeholder="0x..." />
            </div>
            <div class="field-group">
              <label for="to-token">To token address</label>
              <input id="to-token" v-model="toTokenAddress" placeholder="0x..." />
            </div>
            <div class="field-group">
              <label for="slippage">Slippage (%)</label>
              <input id="slippage" v-model="slippage" type="number" min="0" max="100" step="0.1" />
            </div>

            <button class="quote-button" type="button" @click="fetchQuote">
              {{ loading ? 'Fetching quote…' : 'Get quote' }}
            </button>

            <p v-if="error" class="status error">{{ error }}</p>
            <p v-else-if="quote" class="status success">Quote ready</p>
            <p v-else class="status">Preview swap pricing from OpenOcean in a single tab.</p>

            <div v-if="quote" class="quote-card">
              <div><strong>Estimated output</strong><span>{{ quote.outAmount }}</span></div>
              <div><strong>Minimum output</strong><span>{{ quote.minOutAmount }}</span></div>
              <div><strong>Estimated gas</strong><span>{{ quote.estimatedGas }}</span></div>
              <div><strong>Price impact</strong><span>{{ quote.priceImpact }}%</span></div>
              <div v-if="quote.route?.length">
                <strong>Route</strong>
                <span>{{ quote.route.map((item) => item.name || item.dex || 'Route').join(' → ') }}</span>
              </div>
            </div>
          </ion-card-content>
        </ion-card>
      </div>
    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonCard, IonCardHeader, IonCardContent, IonCardTitle, IonCardSubtitle } from '@ionic/vue';

interface SwapRouteItem {
  name?: string;
  dex?: string;
}

interface SwapQuote {
  outAmount: string;
  minOutAmount: string;
  estimatedGas: string;
  priceImpact: string;
  route: SwapRouteItem[];
}

const amount = ref('1');
const fromTokenAddress = ref('0x0000000000000000000000000000000000000000');
const toTokenAddress = ref('0xA0b86991c6218b36c1d2e2f6FfBf7B1BF3A0b869');
const slippage = ref('0.5');
const loading = ref(false);
const error = ref<string | null>(null);
const quote = ref<SwapQuote | null>(null);

async function fetchQuote() {
  if (!amount.value) {
    error.value = 'Enter an amount to continue.';
    quote.value = null;
    return;
  }

  loading.value = true;
  error.value = null;
  quote.value = null;

  try {
    const endpoint = new URL('https://open-api.openocean.finance/v3/1/quote');
    endpoint.searchParams.set('inTokenAddress', fromTokenAddress.value);
    endpoint.searchParams.set('outTokenAddress', toTokenAddress.value);
    endpoint.searchParams.set('amount', String(Math.round(Number(amount.value) * 1e18)));
    endpoint.searchParams.set('slippage', slippage.value);

    const response = await fetch(endpoint.toString());
    if (!response.ok) {
      throw new Error('Unable to fetch a quote right now.');
    }

    const data = await response.json();
    quote.value = {
      outAmount: data.outAmount || data.out_amount || 'n/a',
      minOutAmount: data.minOutAmount || data.min_out_amount || 'n/a',
      estimatedGas: data.estimatedGas || data.estimated_gas || 'n/a',
      priceImpact: data.priceImpact || data.price_impact || '0',
      route: Array.isArray(data.route) ? data.route : []
    };
  } catch (err) {
    error.value = err instanceof Error ? err.message : 'Unable to fetch a quote.';
  } finally {
    loading.value = false;
  }
}
</script>

<style scoped>
.swap-shell {
  padding: 18px;
  display: flex;
  justify-content: center;
}

ion-card {
  width: min(100%, 560px);
  padding: 4px;
  background: linear-gradient(145deg, rgba(17, 24, 39, 0.95), rgba(30, 41, 59, 0.9));
}

.hero-banner {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px 16px 0;
}

.eyebrow {
  text-transform: uppercase;
  letter-spacing: 0.16em;
  font-size: 0.72rem;
  color: #7dd3fc;
  margin: 0 0 4px;
}

h2 {
  margin: 0;
  color: #f8fafc;
  font-size: 1.15rem;
}

.pill {
  padding: 6px 10px;
  border-radius: 999px;
  background: rgba(56, 189, 248, 0.16);
  color: #7dd3fc;
  font-size: 0.8rem;
  font-weight: 600;
}

.field-group {
  display: flex;
  flex-direction: column;
  gap: 8px;
  margin-bottom: 12px;
}

label {
  font-weight: 700;
  color: #f8fafc;
}

input {
  border: 1px solid rgba(255, 255, 255, 0.12);
  border-radius: 12px;
  padding: 12px 14px;
  font: inherit;
  background: rgba(255, 255, 255, 0.06);
  color: #f8fafc;
}

input:focus {
  outline: none;
  border-color: #38bdf8;
  box-shadow: 0 0 0 3px rgba(56, 189, 248, 0.22);
}

.quote-button {
  width: 100%;
  border: none;
  border-radius: 999px;
  padding: 12px 14px;
  background: linear-gradient(135deg, #38bdf8, #4f46e5 70%, #8b5cf6);
  color: white;
  font-weight: 700;
  cursor: pointer;
  margin-top: 4px;
}

.status {
  margin-top: 12px;
  color: #e2e8f0;
}

.status.success {
  color: #86efac;
}

.status.error {
  color: #fda4af;
}

.quote-card {
  margin-top: 14px;
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 16px;
  padding: 12px;
  display: grid;
  gap: 8px;
  background: rgba(255, 255, 255, 0.05);
}

.quote-card div {
  display: flex;
  justify-content: space-between;
  gap: 12px;
  color: #f8fafc;
}
</style>
