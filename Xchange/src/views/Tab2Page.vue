<template>
  <ion-page>
    <ion-header>
      <ion-toolbar>
        <ion-title>Tab 2</ion-title>
      </ion-toolbar>
    </ion-header>
    <ion-content :fullscreen="true">
      <ion-header collapse="condense">
        <ion-toolbar>
          <ion-title size="large">Tab 2</ion-title>
        </ion-toolbar>
      </ion-header>

      <div class="news-list" style="padding:16px;">
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
