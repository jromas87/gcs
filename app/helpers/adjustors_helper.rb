module AdjustorsHelper
	def adjuster_row(label, value)
		content_tag :div, class: "row" do
			doctor_label(label) +
			doctor_value(value)
		end
	end

	def adjuster_label(label)
		content_tag :div, class: "col-xs-4" do
			content_tag :strong, class: "text-primary" do
			 content_tag :p, label
			end
		end
	end

	def adjuster_value(value)
		content_tag :div, class: "col-xs-8" do
			content_tag :p, value
		end
	end
end
