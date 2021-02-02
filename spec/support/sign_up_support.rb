module SignUpSupport
  def sign_up(user, profile)
    visit new_user_registration_path
    fill_in 'nickname', with: user.nickname
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    fill_in 'password-confirmation', with: user.password
    click_on('プロフィール情報入力へ')
    expect(current_path).to eq new_user_registration_path
    fill_in 'address', with: profile.address
    fill_in 'age', with: profile.age
    find('#sex-id').find("option[value='1']").select_option
    expect { click_on('新規登録') }.to change { User.count }.by(1).and change { Profile.count }.by(1)
    expect(current_path).to eq root_path
  end
end
