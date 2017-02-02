CREATE TABLE `todos` (`id` INT(4) not null auto_increment, `title` VARCHAR(255), `text` VARCHAR(255) not null, `created_at` TIMESTAMP not null, `updated_at` TIMESTAMP not null, PRIMARY KEY(`id`));
