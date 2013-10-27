require_relative '../spec_helper'

describe Student do
  context 'with slugs' do
    describe '#slugify!' do
      it "formats a slug based on a student's name" do
        # Remember that subject will by default be a new instance
        # of the class being described.
        subject.name = "Avi Flombaum"
        subject.slugify!

        expect(subject.slug).to eq('avi-flombaum')
      end

      it 'saves the slug to the database on create' do
        # You will need to read this and learn about model hooks.
        # http://sequel.rubyforge.org/rdoc/files/doc/model_hooks_rdoc.html

        subject.name = "Avi Flombaum"
        # before saving, the model hook (before_save) slugifies student name
        subject.save 

        expect(subject.slug).to eq('avi-flombaum')
        expect(Student.find(slug: "avi-flombaum")).to eq(subject)
      end
    end
  end
end
