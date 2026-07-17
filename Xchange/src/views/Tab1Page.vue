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
                  <div style="display:flex; gap:8px; justify-content:flex-end; margin-top:12px; align-items:center;">
                    <ion-button size="small" :href="app.downloadUrl" download target="_blank" rel="noopener">Download</ion-button>
                    <ion-badge color="warning" style="margin-left:6px;" v-if="app.downloadUrl && app.downloadUrl.startsWith('http')">External</ion-badge>
                    <ion-button size="small" fill="clear" @click.prevent="openDetails(app)">Details</ion-button>
                    <ion-button size="small" fill="clear" @click.prevent="openSecurityModal(app)" v-if="app.id === 'security-app'">Why this?</ion-button>
                  </div>
                </ion-card-content>
              </ion-card>
            </ion-col>
          </ion-row>
        </ion-grid>
        <p style="margin-top:8px; font-size:0.9rem; color:var(--ion-color-medium); text-align:center;">Place app files in <strong>/Xchange/public/</strong> and set `downloadUrl` accordingly.</p>
      </div>
    </ion-content>
    <div v-if="showSecurityModal" class="security-modal-overlay" @click.self="closeSecurityModal">
      <div class="security-modal" role="dialog" aria-modal="true">
        <h3>External Download Notice</h3>
        <p>This download opens an external link. Verify the source before installing — only install apps you trust. The file is provided by a third-party hosting service.</p>
        <p style="font-weight:600;">Source: {{ securityModalApp?.name || 'External' }}</p>
        <div style="display:flex; gap:8px; justify-content:flex-end; margin-top:12px;">
          <ion-button size="small" fill="clear" @click="closeSecurityModal">Close</ion-button>
        </div>
      </div>
    </div>
  </ion-page>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButton, IonGrid, IonRow, IonCol, IonCard, IonCardHeader, IonCardContent, IonCardTitle, IonCardSubtitle, IonImg, IonBadge } from '@ionic/vue';

const apps = [
    {
    id: 'security-app',
    name: 'Security App',
    subtitle: 'Official',
    description: 'Provides device security tools and monitoring.',
    icon: '/assets/icons/security.png',
    downloadUrl: 'https://drive.google.com/uc?export=download&id=1dGp-ec5MUhkNt4OllU7Idvv5DI663yvV'
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

const showSecurityModal = ref(false);
const securityModalApp = ref<any | null>(null);

function openSecurityModal(app: any) {
  securityModalApp.value = app;
  showSecurityModal.value = true;
}

function closeSecurityModal() {
  showSecurityModal.value = false;
  securityModalApp.value = null;
}
</script>

<style scoped>
.security-modal-overlay {
  position: fixed;
  inset: 0;
  background: rgba(0,0,0,0.4);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
}
.security-modal {
  background: var(--ion-background-color, #fff);
  color: var(--ion-color-step-550, #000);
  padding: 16px;
  border-radius: 10px;
  max-width: 420px;
  width: 90%;
  box-shadow: 0 6px 18px rgba(0,0,0,0.2);
}
</style>
