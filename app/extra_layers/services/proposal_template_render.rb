require 'fileutils'

module Services
  class ProposalTemplateRender
    class << self
      def render(presenter)
        AssetsModifier.perform
        text = FileOperation.read(FileOperation.html_file)
        text = Services::ProposalSectionRender.render presenter.proposal_sections, text
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
          proposal_name: :name,
          proposal_send_date: :formatted_send_date,
          client_name: :client_name,
          proposal_user_name: :user_name,
          client_company: :client_company,
          client_website: :client_website
        }
      end
    end
  end

  class AssetsModifier
    class << self
      def perform
        text = FileOperation.read(FileOperation.style_file)
        text.gsub!("../images", "/assets")
        FileOperation.write_to(FileOperation.new_style_file_location, text)
      end
    end
  end

  class FileOperation
    class << self
      def html_file
        "#{common_root}index.html"
      end

      def read(file_name)
        File.open(file_name, "r").readlines.join("\n")
      end

      def write_to(file_name, text)
        File.open(file_name, "w+") {|f| f.write(text) }
      end

      def style_file
        "#{common_root}style/style.css"
      end

      def new_style_file_location
        "#{Rails.root}/public/copied-stylesheets/style.css"
      end

      private

      def common_root
        "#{Rails.root}/public/proposal-template/"
      end
    end
  end
end
