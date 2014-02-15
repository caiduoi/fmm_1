class Admin::CsvsController < ApplicationController
	def new
  end

  def export_csv
    send_data(params[:table].classify.constantize.all.to_csv, {filename: params[:table]+".csv"})
  end

  def import_csv
    params[:table].classify.constantize.import(params[:file])
    redirect_to new_admin_csvs_path, notice: "table " + params[:table] + " successfully imported."
  end

  def export_xml
    send_data(params[:table].classify.constantize.all.to_xml, {filename: params[:table]+".xml"})
  end

  def import_xml
    params[:table].classify.constantize.import_xml(params[:file])
    redirect_to new_admin_csvs_path, notice: "table " + params[:table] + " successfully imported."
  end

end
