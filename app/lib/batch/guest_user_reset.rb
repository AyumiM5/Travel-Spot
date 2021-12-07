class Batch::GuestUserReset
  def self.guest_user_reset
    User.find_by(name: 'Guest').destroy
    p 'Guestユーザーの投稿を削除'
  end
end
