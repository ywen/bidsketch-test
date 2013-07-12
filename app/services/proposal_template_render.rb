module Services
  class ProposalTemplateRender
    class << self
      def render
        text = File.open(file_name, "r").readlines.join("\n")
        text.gsub!("images/", "/assets")
        text.gsub!(%Q|<link href=\"style/style.css\" rel=\"stylesheet\" type=\"text/css\" media=\"all\" />|, "")
        text
      end

      private

      def file_name
        "#{Rails.root}/public/proposal-template/index.html"
      end
    end
  end
end
