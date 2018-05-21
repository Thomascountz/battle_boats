module BattleBoats
  module Colorize
    refine String do
      def blue
        "\e[34m#{self}\e[0m"
      end

      def red
        "\e[31m#{self}\e[0m"
      end

      def yellow
        "\e[33m#{self}\e[0m"
      end
    end
  end
end