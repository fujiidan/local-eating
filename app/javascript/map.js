// googleMapの初期位置を設定
function initMap(){
  mapInstance = new google.maps.Map(document.getElementById('map'), {
  center: {lat: 35.662, lng: 139.704},
  zoom: 10
  });
}

// データベースからマーカーの情報取得
function allMap () {
  gon.stores.forEach((store) => {
      let marker = new google.maps.Marker({
      position: {lat: store.latitude, lng: store.longitude},
      map: mapInstance,
    });
      let infoWindow = new google.maps.InfoWindow({
        content: `<div class="mapinfo">
        <p>${store.name}</p>
        <p>${store.address}</p>
        <p>${store.url}</p>
        <a href="/stores/${store.id}"/>リンク</a>
        </div>`
      });
      marker.addListener('click', function() {
        infoWindow.open(mapInstance, marker);
      });
  });
};

window.addEventListener("load", initMap);
window.addEventListener("load", allMap);