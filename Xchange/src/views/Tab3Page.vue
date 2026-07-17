<template>
  <ion-page>
    <ion-header>
      <ion-toolbar>
        <ion-title>Tab 3</ion-title>
      </ion-toolbar>
    </ion-header>
    <ion-content :fullscreen="true">
      <ion-header collapse="condense">
        <ion-toolbar>
          <ion-title size="large">Tab 3</ion-title>
        </ion-toolbar>
      </ion-header>

      <div class="swaps" style="padding:16px;">
        <ion-grid>
          <ion-row>
            <ion-col size="12" v-for="swap in swaps" :key="swap.id">
              <ion-card>
                <ion-card-header>
                  <ion-card-title>{{ swap.pair }}</ion-card-title>
                  <ion-card-subtitle>{{ swap.status }}</ion-card-subtitle>
                </ion-card-header>
                <ion-card-content>
                  <p>{{ swap.details }}</p>
                  <div style="display:flex; gap:8px; justify-content:flex-end; margin-top:12px;">
                    <ion-button size="small" @click.prevent="acceptSwap(swap)" :disabled="swap.status !== 'open'">Accept</ion-button>
                    <ion-button size="small" fill="clear" @click.prevent="viewSwap(swap)">View</ion-button>
                  </div>
                </ion-card-content>
              </ion-card>
            </ion-col>
          </ion-row>
        </ion-grid>
      </div>
    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonGrid, IonRow, IonCol, IonCard, IonCardHeader, IonCardTitle, IonCardSubtitle, IonCardContent, IonButton } from '@ionic/vue';

const swaps = [
  { id: 's1', pair: 'USD ⇄ BTC', status: 'open', details: 'Swap 0.01 BTC for 500 USD.' },
  { id: 's2', pair: 'ETH ⇄ EUR', status: 'filled', details: 'Swap completed for 1.2 ETH.' }
];

function acceptSwap(swap: any) {
  if (swap.status !== 'open') return alert('Swap not open');
  swap.status = 'filled';
  alert(`Accepted swap ${swap.pair}`);
}

function viewSwap(swap: any) {
  alert(`${swap.pair}\n\n${swap.details}\nStatus: ${swap.status}`);
}
</script>
