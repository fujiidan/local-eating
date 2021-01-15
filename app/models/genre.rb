class Genre < ActiveHash::Base
  self.data = [
    { id:1, name: '和食'},
    { id:2, name: '洋食'},
    { id:3, name: '中華'},
    { id:4, name: 'アジア・エスニック'},
    { id:5, name: 'カレー'},
    { id:6, name: '焼き肉・ホルモン'},
    { id:7, name: '鍋'},
    { id:8, name: '居酒屋・ダイニングバー'},
    { id:9, name: 'ラーメン'},
    { id:10, name: 'カフェ'},
    { id:11, name: 'パン・サンドイッチ'},
    { id:12, name: 'スイーツ'},
    { id:13, name: 'ドリンク'},
    { id:14, name: '惣菜惣菜'},
    { id:15, name: 'テイクアウト'},
    { id:16, name: 'その他'}
  ]
end