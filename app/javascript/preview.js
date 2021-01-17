const preview = () => {
  const ImageList = document.getElementById("image-list");
  const createImageHTML = (blob) => {
    // 画像表示する為のdiv要素作成
    const imageElement = document.createElement("div");
    imageElement.setAttribute("class", "image-element");
    let imageElementNum = document.querySelectorAll(".image-element").length;
    // 画像表示の為img要素作成
    const blobImage = document.createElement("img");
    blobImage.setAttribute("src", blob);
    blobImage.setAttribute("class", "preview-image");
    // 画像追加の為のinput要素作成
    const inputHTML = document.createElement("input");
    inputHTML.setAttribute("id", `message_image_${imageElementNum}`);
    inputHTML.setAttribute("name", "store[images][]");
    inputHTML.setAttribute("type", "file")
    inputHTML.setAttribute("class", "form-image-btn")
    // 作成したHTML要素を結合
    imageElement.appendChild(blobImage);
    imageElement.appendChild(inputHTML)
    ImageList.appendChild(imageElement);
    // 作成したいinput要素にイベント追加
    inputHTML.addEventListener("change", (e) => {
      file = e.target.files[0];
      blob = window.URL.createObjectURL(file);
      createImageHTML(blob);
    });
  };

  document.getElementById("images").addEventListener('change', (e) => {
    const file = e.target.files[0];
    const blob = window.URL.createObjectURL(file);
    createImageHTML(blob);
  });
};

window.addEventListener("load", preview);