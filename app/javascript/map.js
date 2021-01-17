function initMap(){
  mapInstance = new google.maps.Map(document.getElementById('map'), {
  center: {lat: 35.662, lng: 139.704},
  zoom: 10
  });
}

function allMap () {
  gon.stores.forEach((store) => {
    let storeName = store.name;
    let marker = new google.maps.Marker({
      position: {lat: store.latitude, lng: store.longitude},
      map: mapInstance,
      title: storeName
    });
  });
};

window.addEventListener("load", initMap);
window.addEventListener("load", allMap);