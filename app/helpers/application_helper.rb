
module ApplicationHelper
  def bootstrap_class_for(flash_type)
    {
      "notice" => "alert-success",
      "alert"  => "alert-danger",
      "error"  => "alert-danger"
    }.fetch(flash_type.to_s, "alert-info")
  end
end