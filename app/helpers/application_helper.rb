module ApplicationHelper


    def markdown_to_html(d_markdown)
      renderer = Redcarpet::Render::HTML.new
      extensions = {fenced_code_blocks: true}
      redcarpet = Redcarpet::Markdown.new(renderer, extensions)
      (redcarpet.render d_markdown).html_safe

    end

end
