package com.cqa.config;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.deser.std.StdDeserializer;
import com.fasterxml.jackson.databind.module.SimpleModule;
import com.fasterxml.jackson.databind.ser.std.StdSerializer;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateDeserializer;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateSerializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalTimeSerializer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;

@Configuration
public class JacksonConfig {

    @Bean
    public ObjectMapper objectMapper() {
        ObjectMapper objectMapper = new ObjectMapper();

        // Set date and time format
        DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        DateTimeFormatter isoDateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSSX");

        // Register JavaTimeModule to support Java 8 date and time types
        JavaTimeModule javaTimeModule = new JavaTimeModule();

        // Add serializers to return date and time in "yyyy-MM-dd HH:mm:ss" format to the frontend
        javaTimeModule.addSerializer(LocalDateTime.class, new LocalDateTimeSerializer(dateTimeFormatter));
        javaTimeModule.addSerializer(LocalDate.class, new LocalDateSerializer(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
        javaTimeModule.addSerializer(LocalTime.class, new LocalTimeSerializer(DateTimeFormatter.ofPattern("HH:mm:ss")));

        // Add deserializers for ISO formatted dates from the frontend
        javaTimeModule.addDeserializer(LocalDateTime.class, new LocalDateTimeDeserializer(isoDateTimeFormatter));
        javaTimeModule.addDeserializer(LocalDate.class, new LocalDateDeserializer(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
        javaTimeModule.addDeserializer(LocalTime.class, new LocalTimeDeserializer(DateTimeFormatter.ofPattern("HH:mm:ss")));

        // Register the module
        objectMapper.registerModule(javaTimeModule);

        // Create custom serializers and deserializers
        SimpleModule module = new SimpleModule();

        // Serializer: Convert Date to "yyyy-MM-dd HH:mm:ss" format
        module.addSerializer(Date.class, new StdSerializer<Date>(Date.class) {
            private static final long serialVersionUID = 1L;
            private SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

            @Override
            public void serialize(Date value, JsonGenerator gen, SerializerProvider provider) throws IOException {
                gen.writeString(dateFormat.format(value));
            }
        });

        // Deserializer: Parse multiple date formats into Date
        module.addDeserializer(Date.class, new StdDeserializer<Date>(Date.class) {
            private static final long serialVersionUID = 1L;
            private SimpleDateFormat[] dateFormats = new SimpleDateFormat[]{
                    new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"),
                    new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSX")
            };

            @Override
            public Date deserialize(JsonParser p, DeserializationContext ctxt) throws IOException {
                String dateStr = p.getValueAsString();
                for (SimpleDateFormat format : dateFormats) {
                    try {
                        return format.parse(dateStr);
                    } catch (ParseException e) {
                        // Try the next format
                    }
                }
                throw new RuntimeException("Unable to parse date format: " + dateStr);
            }
        });

        // Register the module
        objectMapper.registerModule(module);

        // Disable timezone conversion
        objectMapper.configure(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS, false);

        return objectMapper;
    }
}
