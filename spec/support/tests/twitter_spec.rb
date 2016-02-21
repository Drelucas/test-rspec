require 'webdriver_helper'

describe 'acesso ao twitter' do
  let(:twitte) { 'Texto para twittar' }

  it 'logar no twitter com sucesso' do
    twitter.url_twitter
    twitter.login
    expect(twitter.text_user).to eql('drelucastest')
  end

  context 'verificar valores limitrofes de caracteres' do
    it 'informando menos de 140 caracteres deve habilitar o botão de twittar ' do
      menor = 'testestestestestestestestestestestestestestestestestestestes'
      twitter.click_text_twitter
      twitter.fill_twitter(menor)
      expect(twitter.twittar_disable?).to be false
    end

    it 'informando 140 caracteres deve habilitar o botão de twittar ' do
      exato = 'testestestestestestestestestestestestestestestestestestestestestestestestestestestestestestestestestestestestestestestestestestestestestest'
      twitter.click_text_twitter
      twitter.fill_twitter(exato)
      expect(twitter.twittar_disable?).to be false
    end

    it 'informando mais de 140 caracteres deve desbilitar o botão de twittar ' do
      maior = 'testestestestestestestestestestestestestestestestestestestestestestestestestestestestestestestestestestestestestestestestestestestestestestes'
      twitter.click_text_twitter
      twitter.fill_twitter(maior)
      expect(twitter.twittar_disable?).to be true
    end
  end

  context 'postar um twitter' do
    it 'postar um twitter com sucesso' do
      twitter.click_text_twitter
      twitter.fill_twitter(twitte)
      twitter.click_twittar
      expect(twitter.text_posted).to eql(twitte)
    end
  end
end
