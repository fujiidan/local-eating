module CreateStoreSupport
  def create_store(user, store)
    sign_in(user)
    click_on('飲食店を追加する')
    fill_in 'name', with: store.name
    fill_in 'address', with: store.address
    fill_in 'url', with: store.url
    find('#genre-id').find("option[value='1']").select_option
    find('#price-id').find("option[value='1']").select_option
    fill_in 'info', with: store.info
    image_path = Rails.root.join('public/images/test_image.png')
    attach_file('store[store_images][]', image_path)
    expect { click_on('店舗登録') }.to change { Store.count }.by(1)
    expect(current_path).to eq store_path(1)
  end
end
