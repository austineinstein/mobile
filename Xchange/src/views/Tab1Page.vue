<template>
  <ion-page>
    <ion-header>
      <ion-toolbar>
        <ion-title>Apps</ion-title>
      </ion-toolbar>
    </ion-header>
    <ion-content :fullscreen="true">
      <ion-header collapse="condense">
        <ion-toolbar>
          <ion-title size="large">Apps</ion-title>
        </ion-toolbar>
      </ion-header>

      <div class="apps-grid" style="padding:16px;">
        <ion-grid>
          <ion-row>
            <ion-col size-sm="6" size-md="4" size-lg="3" v-for="app in apps" :key="app.id">
              <ion-card>
                <ion-img :src="app.icon" alt="app.name icon"></ion-img>
                <ion-card-header>
                  <ion-card-title>{{ app.name }}</ion-card-title>
                  <ion-card-subtitle>{{ app.subtitle }}</ion-card-subtitle>
                </ion-card-header>
                <ion-card-content>
                  <p>{{ app.description }}</p>
                  <div style="display:flex; gap:8px; justify-content:flex-end; margin-top:12px;">
                    <ion-button size="small" :href="app.downloadUrl" download target="_blank" rel="noopener">Download</ion-button>
                    <ion-button size="small" fill="clear" @click.prevent="openDetails(app)">Details</ion-button>
                  </div>
                </ion-card-content>
              </ion-card>
            </ion-col>
          </ion-row>
        </ion-grid>
        <p style="margin-top:8px; font-size:0.9rem; color:var(--ion-color-medium); text-align:center;">Place app files in <strong>/Xchange/public/</strong> and set `downloadUrl` accordingly.</p>
      </div>
    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButton, IonGrid, IonRow, IonCol, IonCard, IonCardHeader, IonCardContent, IonCardTitle, IonCardSubtitle, IonImg } from '@ionic/vue';

const apps = [
  {
    id: 'security-app',
    name: 'Security App',
    subtitle: 'Official',
    description: 'Provides device security tools and monitoring.',
    icon: '/assets/icons/security.png',
    downloadUrl: '/security-app.apk'
  },
  {
    id: 'scanner-app',
    name: 'Scanner',
    subtitle: 'Beta',
    description: 'Quick scanner for documents and QR codes.',
    icon: '/assets/icons/scanner.png',
    downloadUrl: '/scanner-app.apk'
  }
];

function openDetails(app: any) {
  // placeholder - could open modal or navigate to details page
  alert(`${app.name}: ${app.description}`);
}
</script>
