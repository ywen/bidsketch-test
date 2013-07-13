module Services
  class ProposalTemplateRender
    class << self
      def render(presenter)
        text = File.open(file_name, "r").readlines.join("\n")
        text.gsub!("images/", "/assets/")
        text.gsub!(%Q|<link href=\"style/style.css\" rel=\"stylesheet\" type=\"text/css\" media=\"all\" />|, "")
        replacing_attributes.each do |attr, method_name|
          text.gsub!("{#{attr}}", presenter.send(method_name))
        end
        text
      end

      private

      def replacing_attributes
        {
          proposal_name: :name
        }
      end

      def file_name
        "#{Rails.root}/public/proposal-template/index.html"
      end
    end
  end
end
