<template>
  <ion-page>
    <ion-header>
      <ion-toolbar>
        <ion-title>Insights</ion-title>
      </ion-toolbar>
    </ion-header>
    <ion-content :fullscreen="true">
      <ion-header collapse="condense">
        <ion-toolbar>
          <ion-title size="large">News</ion-title>
        </ion-toolbar>
      </ion-header>

      <div class="news-list">
        <div class="hero-card">
          <p class="eyebrow">Live market pulse</p>
          <h2>Stay ahead with the latest updates.</h2>
          <p>Curated product, market, and security notifications tailored for quick reading.</p>
        </div>

        <ion-list>
          <ion-item v-for="item in news" :key="item.id" button @click="openArticle(item)">
            <ion-label>
              <h3>{{ item.title }}</h3>
              <p>{{ item.summary }}</p>
            </ion-label>
            <ion-note slot="end">{{ item.time }}</ion-note>
          </ion-item>
        </ion-list>
      </div>
    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonList, IonItem, IonLabel, IonNote } from '@ionic/vue';

const news = [
  { id: 'n1', title: 'Security update released', summary: 'New security patch available for the app.', time: '2h' },
  { id: 'n2', title: 'Maintenance scheduled', summary: 'Planned downtime for upgrades.', time: '1d' },
  { id: 'n3', title: 'Feature: Swap UI improvements', summary: ' Faster swaps and improved confirmations.', time: '3d' }
];

function openArticle(item: any) {
  alert(`${item.title}\n\n${item.summary}`);
}
</script>

<style scoped>
.news-list {
  padding: 18px;
  display: flex;
  flex-direction: column;
  gap: 14px;
}

.hero-card {
  padding: 16px;
  border-radius: 20px;
  background: linear-gradient(135deg, rgba(56, 189, 248, 0.16), rgba(139, 92, 246, 0.18));
  border: 1px solid rgba(255, 255, 255, 0.12);
}

.eyebrow {
  text-transform: uppercase;
  letter-spacing: 0.16em;
  font-size: 0.72rem;
  color: #7dd3fc;
  margin: 0 0 6px;
}

h2 {
  margin: 0 0 8px;
  font-size: 1.18rem;
  color: #f8fafc;
}

.hero-card p {
  margin: 0;
  color: #e2e8f0;
}
</style>
