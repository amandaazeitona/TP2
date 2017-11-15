module Escrita
  def Substituir(filepath, substituir, &block)
    content = File.read(filepath).gsub(substituir, &block)
    File.open(filepath, 'wb') { |file| file.write(content) }
  end

  def SalvaScore(arquivo, pontuacao, nome)
    filepath = File.open(arquivo,"r+")
    s_subs = ""
    achou_menor = false

    # Busca a posicao no arquivo, se encontrar uma menor que a atual, armazena em s_subs
    File.open(filepath).each do |line|

      number = line[/\d+/].to_i
      name = line[/\D+/]
      if pontuacao > number
        s_subs = "#{number}#{name}".to_s
        achou_menor = true
        break
      end
    end

    # Salva os dados do player em uma string
    meus_dados = "#{pontuacao} #{nome}\n"

    # Se houver um menor, salva na posicao adequada, senão salva no fim do arquivo.
    if achou_menor == true
      Substituir(filepath, s_subs) { |match| meus_dados+s_subs}
    else
      File.open(filepath, 'a') { |file| file.write(meus_dados) }
    end
  end
end

module Leitura
  def DezPrimeiros(arquivo)
    i=1
    filepath = File.open(arquivo,"r+")
    puts "POS - Pontuação Nome"
    filepath.each do |line|
      if i == 11
        break
      end
      puts "#{i} - #{line}"
      i=i+1
    end
  end
end

class Pontuacao

  include Escrita
  include Leitura

end

inserir = Pontuacao.new
# Os parametros esperados sao o nome do arquivo (string), a pontuacao (int), e o nome do player (string)
#inserir.SalvaScore("ranking.txt", 125, "CCC")
#inserir.DezPrimeiros("ranking.txt")
