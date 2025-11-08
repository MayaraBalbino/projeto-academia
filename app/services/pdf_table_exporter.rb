require 'prawn'
require 'prawn/table'

class PdfTableExporter
  HEADER_ROW_COLOR = '333333'
  HEADER_TEXT_COLOR = 'FFFFFF'
  ROW_COLORS = %w[F7F7F7 FFFFFF].freeze

  def self.generate(title:, headers:, rows:)
    Prawn::Document.new do |pdf|
      pdf.text title, size: 18, style: :bold, align: :center
      pdf.move_down 12
      data = [headers] + rows
      pdf.table(data, header: true, row_colors: ROW_COLORS, width: pdf.bounds.width) do
        row(0).font_style = :bold
        row(0).background_color = HEADER_ROW_COLOR
        row(0).text_color = HEADER_TEXT_COLOR
      end
    end
  end
end
