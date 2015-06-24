module Api
  module ProposedLaws
    # For interaction with nodes
    class NodesController < WorkingFilesController
      expose :node do
        working_file.node
      end
      expose :nodes do
        node.child_nodes
      end
      expose :attributes do
        params[:attributes]
      end
      expose :recurse do
        tree_base == 'proposed-law'
      end

      def index
        respond_to do |format|
          format.json do
            if node.exists?
              render 'index', status: 200
            else
              render nothing: true, status: 404
            end
          end
        end
      end

      def show
        respond_to do |format|
          format.json do
            if node.exists?
              render 'show', status: 200
            else
              render nothing: true, status: 404
            end
          end
        end
      end

      def create
        node.attributes = attributes
        respond_to do |format|
          format.json do
            if node.create
              render nothing: true, status: 201
            else
              render 'errors', status: 422
            end
          end
        end
      end

      def update
        respond_to do |format|
          format.json do
            if !node.exists?
              render nothing: true, status: 404
            elsif ( to_tree ? move_and_update_node : update_node )
              render 'show', status: 200
            else
              render 'errors', status: 422
            end
          end
        end
      end

      def destroy
        respond_to do |format|
          format.json do
            node.destroy
            render nothing: true, status: 204
          end
        end
      end

      protected

      def to_tree_base
        return @to_tree_base unless @to_tree_base.nil?
        @to_tree_base = if params[:to_tree_base] && params[:to_tree_base].present?
          params[:to_tree_base]
        else
          false
        end
      end

      def to_tree
        return @to_tree unless @to_tree.nil?
        @to_tree = if to_tree_base
          "#{to_tree_base}.json"
        else
          false
        end
      end

      def tree_base
        @tree_base ||= params[:tree_base] ? params[:tree_base] : ''
      end

      def tree
        @tree ||= tree_base && tree_base.present? ? "#{tree_base}.json" : ''
      end

      # Move the node, then update the moved node
      def move_and_update_node
        newNode = node.move to_tree
        if newNode
          self.node = newNode
          update_node
        else
          false
        end
      end

      # Update the node in place
      def update_node
        node.attributes = attributes
        node.update
      end
    end
  end
end