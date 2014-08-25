class Post < ActiveRecord::Base

	
	after_save :guardar_foto
	FOTOS = File.join Rails.root, 'public', 'photo_store'
	

	def photo=(file_data)

		unless file_data.blank? #solo se ejecuta en caso de que contenga algo
			@file_data = file_data
			self.extension = file_data.original_filename.split('.').last.downcase #self hace referencia ala base de datos (al campo)
		end
	end

	def photo_filename
		File.join FOTOS, "#{id}.#{extension}"
	end

	def photo_path
		"/photo_store/#{id}.#{extension}"
	end

	def has_photo?
		File.exists? photo_filename
	end

	private
	def guardar_foto

		if @file_data
			FileUtils.mkdir_p FOTOS #crea el directorio FOTOS
			File.open(photo_filename,'wb') do |f| #abrir archivo photo_filename que es el nombre del archivo
				f.write(@file_data.read)
			end
			@file_data = nil #libera variable
		end
	end
end
