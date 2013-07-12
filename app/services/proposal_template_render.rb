module Services
  class ProposalTemplateRender
    class << self
      def render
        File.open(file_name, "r").readlines
      end

      private

      def file_name
        "#{Rails.root}/public/proposal-template/index.html"
      end
    end
  end
end
