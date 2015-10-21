class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, presence: true
  validate :approved_overlapping_requests

  belongs_to(
    :cat,
    class_name: "Cat",
    primary_key: :id,
    foreign_key: :cat_id
  )

  private

  def overlapping_requests
    overlaps = cat.rental_requests
      .where("NOT (end_date < ? OR start_date > ?)", self.start_date, self.end_date)
  end

  def approved_overlapping_requests
    approved_overlaps = overlapping_requests
      .select{ |request| request.status == "APPROVED" }

    unless approved_overlaps.empty?
      status = "DENIED"
      errors[:valid_request] << "You can't make overlapping requests"
    end
  end

    # else
    #   deny_overlapping_approved_requests(overlaps)

  #     if request.status == "APPROVED"
  #       if !(request.end_date < self.start_date ||
  #            request.start_date > self.end_date)
  #         errors[:valid_request] << "Request overlaps with an existing request"
  #       end
  #     end
  #   end
  # end
  #
  # def deny_overlapping_approved_requests(unapproved_overlaps)
  #   unapproved_overlaps.each do |request|
  #     request.update('status = ?', "DENIED")
  #   end
  # end

end
