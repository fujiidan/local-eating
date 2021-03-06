// googleMapの初期位置を設定トップページ、店舗詳細ページ、マイページ
function initMap(){
  // 店舗詳細ページの場合の条件分岐
  if (document.getElementById('store-map')) {
    let mapInstance = new google.maps.Map(document.getElementById('store-map'), {
      center: {lat: gon.store.latitude, lng: gon.store.longitude},
      zoom: 16
      });
      let marker = new google.maps.Marker({
        position: {lat: gon.store.latitude, lng: gon.store.longitude},
        map: mapInstance
      });
      let infoWindow = new google.maps.InfoWindow({
        content: `<div class="map-info" id="map-info">
        <p>${gon.store.name}</p>
        <p>${gon.store.address}</p>
        </div>`
      });
      infoWindow.open(mapInstance, marker);
    // マイページ、お気に入りページ場合の条件分岐
  } else if (document.getElementById('user-map')) {
      mapInstance = new google.maps.Map(document.getElementById('user-map'), {
      center: {lat: gon.profile.latitude, lng: gon.profile.longitude},
      zoom: 15
      });
      let marker = new google.maps.Marker({
        position: {lat: gon.profile.latitude, lng: gon.profile.longitude},
        map: mapInstance
      });
      let infoWindow = new google.maps.InfoWindow({
        content: `<div class="map-info id="map-info">
        <p>${gon.profile.address}</p>
        </div>`
      });
      infoWindow.open(mapInstance, marker);
    // トップページ場合の条件分岐
  } else {
      mapInstance = new google.maps.Map(document.getElementById('map'), {
      center: {lat: 35.658581, lng: 139.745433},
      zoom: 15
    });
  }
}
// データベースからマーカーの情報取得 トップページ、マイページ、お気に入りページ
function allMap () {
  gon.stores.forEach((store) => {
      let marker = new google.maps.Marker({
      position: {lat: store.latitude, lng: store.longitude},
      map: mapInstance
    });
      let infoWindow = new google.maps.InfoWindow({
        content: `<div class="map-store-info" id="${store.id}">
        <p>${store.name}</p>
        <p>${store.address}</p>
        <a href="/stores/${store.id}"/>店舗詳細ページへ！</a>
        </div>`
      });
      marker.addListener('click', function() {
        infoWindow.open(mapInstance, marker);
      });
  });
};
// urlで発火イベント制限
if (location.pathname.match(/users.+\d$/) || location.pathname.match(/users.+favorite$/) || location.pathname.match(/stores.+\d$/) || location.pathname.match(/^\/$/)) {
  window.addEventListener("load", initMap);
}
if (location.pathname.match(/users.+\d$/) || location.pathname.match(/users.+favorite$/) || location.pathname.match(/^\/$/)) {
  window.addEventListener("load", allMap);
}