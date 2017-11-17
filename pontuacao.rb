# Modulo que escreve a pontuacao.
module Escrita
  private def substituir(filepath, substituir, &block)
    content = File.read(filepath).sub(substituir, &block)
    File.open(filepath, 'wb') { |file| file.write(content) }
  end

  def salva_score(arquivo, pontuacao, nome)
    filepath = File.open(arquivo, 'r+')
    s_subs = ''
    achou_menor = false

    # Busca a posicao no arquivo, se encontrar uma menor que a atual, armazena em s_subs.
    File.open(filepath).each do |line|
      number = line[/\d+/].to_i
      name = line[/\D+/]
      if pontuacao > number
        s_subs = "#{number}#{name}".to_s
        achou_menor = true
        break
      end
    end

    # Salva os dados do player em uma string.
    meus_dados = "#{pontuacao} #{nome}\n"

    # Se houver um menor, salva na posicao adequada, senao salva no fim do arquivo.
    if achou_menor == true
      substituir(filepath, s_subs) { |match| meus_dados + s_subs }
    else
      File.open(filepath, 'a') { |file| file.write(meus_dados) }
    end
  end
end
# Modulo que le o arquivo texto com o ranking.
module Leitura
  def dez_primeiros(arquivo)
    i = 1
    filepath = File.open(arquivo, 'r+')
    ranking = "Aperte ENTER para voltar\n" #Precisa ficar com aspas duplas para poder pular a linha
    ranking += "POS - Pontuação Nome\n"
    filepath.each do |line|
      if i == 11
        break
      end
      ranking += "#{i} - #{line}"
      i += 1
    end
    ranking
  end
end
# Classe que engloba escrita e leitura.
class Pontuacao
  include Escrita
  include Leitura
end

# inserir = Pontuacao.new
# Os parametros esperados sao o nome do arquivo (string), a pontuacao (int), e o nome do player (string)
# inserir.SalvaScore("ranking.txt", 148, "AAA")
# inserir.DezPrimeiros("ranking.txt")
