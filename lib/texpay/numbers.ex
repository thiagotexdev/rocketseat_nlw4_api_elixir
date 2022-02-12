defmodule Texpay.Numbers do
  # pattern match
  def sum_from_file(filename) do
    # usando pipe operator
    "#{filename}.csv"
    |> File.read()
    |> handle_file()

    # código sem pipe operator
    # file = File.read("#{filename}.csv")
    # handle_file(file)
  end

  # sintax sugar, açúcar sintático utilizado aqui.
  # defp handle_file({:ok, file}), do: file


  defp handle_file({:ok, result}) do
    # usando o pipe operator.
    # o dado trabalhado é o primeiro argumento da função, devemos manter este padrão para utilizar pipe operator.
    # programação funcional é como uma linha de produção em chão de fábrica.

    # o modulo stream faz a mesma coisa que o enum, porém é um operador lazy
    # ou seja, só executa se vc precisar mesmo do resultado

    result =
      result
      |> String.split(",")
      # |> Enum.map(fn number -> String.to_integer(number) end)
      |> Stream.map(fn number -> String.to_integer(number) end)
      |> Enum.sum()

      # map, também conhecido como hash, é um chave valor
    {:ok, %{result: result}}

    # forma normal.
    # result = String.split(result, ",")
    # result = Enum.map(result, fn number -> String.to_integer(number) end)
    # result = Enum.sum(result)
    # result
  end

  # sintax sugar.
  defp handle_file({:error, _reason}), do: {:error, %{message: "Invalid File!"}}

end
