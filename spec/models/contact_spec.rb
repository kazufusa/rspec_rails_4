require 'spec_helper'

describe Contact do

  it 'has a valid factory' do
    expect(build(:contact)).to be_valid
  end

  it 'has three phone numbers' do
    expect(build(:contact).phones.length).to eq 3
  end

  it 'is invalid without a firstname' do
    expect( build(:contact, firstname: nil)).to have(1).errors_on(:firstname)
  end

  it 'is invalid without a lastname' do
    expect( build(:contact, lastname: nil)).to have(1).errors_on(:lastname)
  end

  it 'is invalid without a email address' do
    expect( build(:contact, email: nil)).to have(1).errors_on(:email)
  end

  it 'is invalid with a duplicate email address' do
    create(:contact, email: 'tester@example.com')
    contact = build(:contact, email: 'tester@example.com')

    expect(contact).to have(1).errors_on(:email)
  end

  it 'returns a contact\'s full name as a string' do
    contact = build(:contact, firstname: 'John', lastname: 'Doe')
    expect(contact.name).to eq 'John Doe'
  end

  describe 'filter last name by letter' do

    before :each do
      @smith   = create(:contact, firstname: 'John', lastname: 'Smith')
      @jones   = create(:contact, firstname: 'Tim', lastname: 'Jones')
      @johnson = create(:contact, firstname: 'John', lastname: 'Johnson')
    end

    context 'matching letters' do
      it 'returns a sorted array of results that match' do
        expect(Contact.by_letter 'J' ).to eq [@johnson, @jones]
      end
    end

    context 'non-matching letters' do
      it 'returns a sorted array of results that match' do
        expect(Contact.by_letter 'J' ).to_not include @smith
      end
    end

  end
end
